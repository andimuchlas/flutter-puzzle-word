import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 3D Tactile Button reflecting Stitch design specification:
/// A solid bottom bevel edge shadow (`shadowHeight`), depressing `translateY` on press,
/// and collapsing the bevel for a tactile physical game piece sensation.
class TactileButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color bevelColor;
  final double borderRadius;
  final double shadowHeight;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;

  const TactileButton({
    super.key,
    required this.child,
    this.onPressed,
    required this.backgroundColor,
    required this.bevelColor,
    this.borderRadius = 16.0,
    this.shadowHeight = 4.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.width,
    this.height,
  });

  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = true);
    HapticFeedback.selectionClick();
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = false);
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final currentShadow = _isPressed ? 1.0 : widget.shadowHeight;
    final translateY = _isPressed ? (widget.shadowHeight - 1.0) : 0.0;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Transform.translate(
        offset: Offset(0, translateY),
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: widget.bevelColor,
                offset: Offset(0, currentShadow),
                blurRadius: 0,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
