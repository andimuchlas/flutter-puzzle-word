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
  final double size;

  const LetterWheelWidget({
    super.key,
    required this.letters,
    required this.onWordSubmitted,
    this.onShuffle,
    this.onClear,
    this.size = 280.0,
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
      _currentLetters = List.from(widget.letters);
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
    final nodeRadius = wheelRadius * 0.72;
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
    final idx = _findNearestIndex(localPos, positions, 36.0);
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
    final idx = _findNearestIndex(localPos, positions, 36.0);
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Controls Bar (Shuffle, Hubungkan Huruf, Backspace)
        SizedBox(
          width: wheelSize,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Shuffle Button
                GestureDetector(
                  onTap: _shuffle,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                      border: Border.all(color: IslandColors.outlineLight),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x100F172A),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.shuffle,
                      size: 20,
                      color: IslandColors.primaryLight,
                    ),
                  ),
                ),

                // Title label or Current Word Preview
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: _selectedIndices.isNotEmpty
                      ? Container(
                          key: ValueKey(_currentWord),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            color: IslandColors.primary,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: const [
                              BoxShadow(
                                color: IslandColors.primaryDark,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            _currentWord,
                            style: IslandTypography.headlineSm(
                                color: Colors.white),
                          ),
                        )
                      : Text(
                          'HUBUNGKAN HURUF',
                          key: const ValueKey('prompt_label'),
                          style: IslandTypography.labelSm(
                            color: IslandColors.onSurfaceVariant,
                          ),
                        ),
                ),

                // Clear Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndices.clear();
                      _currentDragPos = null;
                    });
                    HapticFeedback.lightImpact();
                    widget.onClear?.call();
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                      border: Border.all(color: IslandColors.outlineLight),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x100F172A),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.backspace_outlined,
                      size: 18,
                      color: Color(0xFFF43F5E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Letter Wheel Interactive Canvas
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
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xF0FFFFFF),
                          Color(0xE8F1F5F9),
                          Color(0xE8E0F2FE),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.85),
                        width: 4,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x180F172A),
                          offset: Offset(0, 8),
                          blurRadius: 20,
                        ),
                        BoxShadow(
                          color: Color(0x10DAE2FD),
                          offset: Offset(0, 2),
                          blurRadius: 0,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),

                  // 2. Inner Dashed Guideline Ring
                  Container(
                    width: wheelSize - 40,
                    height: wheelSize - 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: IslandColors.outlineVariant.withOpacity(0.4),
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),

                  // 3. Trailing Cyan Ribbon Painter
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
                      left: positions[i].dx - 27,
                      top: positions[i].dy - 27,
                      child: _buildLetterNode(i),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLetterNode(int index) {
    final isSelected = _selectedIndices.contains(index);
    final letter = _currentLetters[index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? IslandColors.primaryLight : Colors.transparent,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: IslandColors.primaryLight.withOpacity(0.5),
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
            color: isSelected ? Colors.white : IslandColors.onSurface,
          ).copyWith(fontSize: 28),
        ),
      ),
    );
  }
}
