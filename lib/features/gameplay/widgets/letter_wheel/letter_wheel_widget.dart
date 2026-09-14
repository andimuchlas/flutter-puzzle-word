import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/island_colors.dart';
import '../../../../core/theme/island_typography.dart';
import 'letter_ribbon_painter.dart';

class LetterWheelWidget extends StatefulWidget {
  final List<String> letters;
  final ValueChanged<String> onWordSubmitted;
  final VoidCallback? onShuffle;
  final VoidCallback? onClear;
  final VoidCallback? onLetterHint;
  final int letterHintCount;
  final VoidCallback? onWordHint;
  final int wordHintCount;
  final VoidCallback? onTargetHint;
  final int targetHintCount;
  final double size;

  const LetterWheelWidget({
    super.key,
    required this.letters,
    required this.onWordSubmitted,
    this.onShuffle,
    this.onClear,
    this.onLetterHint,
    this.letterHintCount = 0,
    this.onWordHint,
    this.wordHintCount = 0,
    this.onTargetHint,
    this.targetHintCount = 0,
    this.size = 210.0,
  });

  @override
  State<LetterWheelWidget> createState() => _LetterWheelWidgetState();
}

class _LetterWheelWidgetState extends State<LetterWheelWidget>
    with SingleTickerProviderStateMixin {
  late List<String> _currentLetters;
  final List<int> _selectedIndices = [];
  Offset? _currentDragPos;
  late AnimationController _shuffleAnimController;

  @override
  void initState() {
    super.initState();
    _currentLetters = List.from(widget.letters);
    _shuffleAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void didUpdateWidget(covariant LetterWheelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.letters != widget.letters) {
      setState(() {
        _currentLetters = List.from(widget.letters);
        _selectedIndices.clear();
        _currentDragPos = null;
      });
    }
  }

  @override
  void dispose() {
    _shuffleAnimController.dispose();
    super.dispose();
  }

  void _shuffle() {
    _shuffleAnimController.forward(from: 0.0).then((_) {
      setState(() {
        _currentLetters.shuffle();
      });
    });
    HapticFeedback.mediumImpact();
    widget.onShuffle?.call();
  }

  List<Offset> _calculatePositions(double wheelRadius, Offset center) {
    final positions = <Offset>[];
    final count = _currentLetters.length;
    if (count == 0) return positions;

    // Radius for letter centers
    final nodeRadius = wheelRadius * 0.70;
    for (int i = 0; i < count; i++) {
      final angle = -math.pi / 2 + (i * 2 * math.pi / count);
      final x = center.dx + nodeRadius * math.cos(angle);
      final y = center.dy + nodeRadius * math.sin(angle);
      positions.add(Offset(x, y));
    }
    return positions;
  }

  int? _findNearestIndex(Offset localPos, List<Offset> positions, double threshold) {
    for (int i = 0; i < positions.length; i++) {
      final dist = (localPos - positions[i]).distance;
      if (dist <= threshold) {
        return i;
      }
    }
    return null;
  }

  void _handlePanStart(DragStartDetails details, List<Offset> positions) {
    final localPos = details.localPosition;
    final scale = (widget.size / 260.0).clamp(0.7, 1.2);
    final threshold = (_currentLetters.length > 8 ? 28.0 : 36.0) * scale;
    final idx = _findNearestIndex(localPos, positions, threshold);
    setState(() {
      _selectedIndices.clear();
      if (idx != null) {
        _selectedIndices.add(idx);
        HapticFeedback.selectionClick();
      }
      _currentDragPos = localPos;
    });
  }

  void _handlePanUpdate(DragUpdateDetails details, List<Offset> positions) {
    final localPos = details.localPosition;
    final scale = (widget.size / 260.0).clamp(0.7, 1.2);
    final threshold = (_currentLetters.length > 8 ? 28.0 : 36.0) * scale;
    final idx = _findNearestIndex(localPos, positions, threshold);
    setState(() {
      _currentDragPos = localPos;
      if (idx != null && !_selectedIndices.contains(idx)) {
        _selectedIndices.add(idx);
        HapticFeedback.selectionClick();
      }
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    if (_selectedIndices.isNotEmpty) {
      final wordBuffer = StringBuffer();
      for (final idx in _selectedIndices) {
        wordBuffer.write(_currentLetters[idx]);
      }
      widget.onWordSubmitted(wordBuffer.toString());
    }

    setState(() {
      _selectedIndices.clear();
      _currentDragPos = null;
    });
  }

  String get _currentWord {
    final buffer = StringBuffer();
    for (final idx in _selectedIndices) {
      buffer.write(_currentLetters[idx]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final wheelSize = widget.size;
    final center = Offset(wheelSize / 2, wheelSize / 2);
    final positions = _calculatePositions(wheelSize / 2, center);

    final isDense = _currentLetters.length > 8;
    final nodeDiameter = isDense
        ? (wheelSize < 240 ? 36.0 : 44.0)
        : (wheelSize < 240 ? 42.0 : 52.0);
    final fontSize = isDense
        ? (wheelSize < 240 ? 17.0 : 22.0)
        : (wheelSize < 240 ? 20.0 : 26.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Live Word Preview Pill floating above the wheel
        Container(
          height: 38,
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: _selectedIndices.isNotEmpty
                ? Container(
                    key: ValueKey(_currentWord),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xEE1E1B4B),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.5), width: 1.2),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      _currentWord,
                      style: IslandTypography.headlineSm(
                        color: Colors.white,
                      ).copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),

        const SizedBox(height: 4),

        // Hub: Left Action Buttons + Letter Wheel Disc + Right Action Buttons
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Action Column: Shuffle (top) + Target Hint (bottom)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSideCircleButton(
                    icon: Icons.shuffle,
                    onTap: _shuffle,
                  ),
                  const SizedBox(height: 18),
                  _buildSideCircleButton(
                    icon: Icons.adjust,
                    onTap: widget.onTargetHint,
                    count: widget.targetHintCount,
                    badgeColor: const Color(0xFF10B981),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              // Center: Tactile Letter Wheel Disc
              GestureDetector(
                onPanStart: (d) => _handlePanStart(d, positions),
                onPanUpdate: (d) => _handlePanUpdate(d, positions),
                onPanEnd: _handlePanEnd,
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _shuffleAnimController,
                      curve: Curves.easeInOutBack,
                    ),
                  ),
                  child: SizedBox(
                    width: wheelSize,
                    height: wheelSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 1. Disc Base Container
                        Container(
                          width: wheelSize,
                          height: wheelSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.84),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.95),
                              width: 3.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x35000000),
                                offset: Offset(0, 6),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                        ),

                        // 2. Inner Guide Ring
                        Container(
                          width: wheelSize - 38,
                          height: wheelSize - 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  IslandColors.outlineVariant.withOpacity(0.30),
                              width: 1.5,
                            ),
                          ),
                        ),

                        // 3. Trailing Ribbon Painter
                        CustomPaint(
                          size: Size(wheelSize, wheelSize),
                          painter: LetterRibbonPainter(
                            letterPositions: positions,
                            selectedIndices: _selectedIndices,
                            currentDragPos: _currentDragPos,
                          ),
                        ),

                        // 4. Radial Letter Nodes
                        for (int i = 0; i < positions.length; i++) ...[
                          Positioned(
                            left: positions[i].dx - (nodeDiameter / 2),
                            top: positions[i].dy - (nodeDiameter / 2),
                            child: _buildLetterNode(i, nodeDiameter, fontSize),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Right Action Column: Lightbulb Hint (top) + Rocket/Word Hint (bottom)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSideCircleButton(
                    icon: Icons.lightbulb_outline,
                    onTap: widget.onLetterHint,
                    count: widget.letterHintCount,
                    badgeColor: const Color(0xFFF59E0B),
                  ),
                  const SizedBox(height: 18),
                  _buildSideCircleButton(
                    icon: Icons.rocket_launch_outlined,
                    onTap: widget.onWordHint,
                    count: widget.wordHintCount,
                    badgeColor: const Color(0xFF6366F1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSideCircleButton({
    required IconData icon,
    required VoidCallback? onTap,
    int? count,
    Color badgeColor = const Color(0xFFEF4444),
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.42),
              border: Border.all(
                color: Colors.white.withOpacity(0.60),
                width: 1.5,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x25000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 22,
              color: Colors.white,
            ),
          ),
          if (count != null && count > 0)
            Positioned(
              top: -3,
              right: -3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white, width: 1.2),
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Center(
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLetterNode(int index, double diameter, double fontSize) {
    final isSelected = _selectedIndices.contains(index);
    final letter = _currentLetters[index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.55),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          letter,
          style: IslandTypography.displayLg(
            color: isSelected ? Colors.white : const Color(0xFF1E293B),
          ).copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
