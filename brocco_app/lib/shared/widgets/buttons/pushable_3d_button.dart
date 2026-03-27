import 'package:flutter/material.dart';

class Pushable3DButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color shadowColor;
  final double shadowOffset;
  final BorderRadius borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry padding;

  const Pushable3DButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.backgroundColor,
    required this.shadowColor,
    this.shadowOffset = 4.0,
    required this.borderRadius,
    this.border,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<Pushable3DButton> createState() => _Pushable3DButtonState();
}

class _Pushable3DButtonState extends State<Pushable3DButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = true);
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
      widget.onPressed?.call();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final dy = _isPressed ? widget.shadowOffset : 0.0;

    return GestureDetector(
      onTapDown: isDisabled ? null : _onTapDown,
      onTapUp: isDisabled ? null : _onTapUp,
      onTapCancel: isDisabled ? null : _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutQuad,
        padding: widget.padding,
        transform: Matrix4.translationValues(0, dy, 0),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          border: widget.border,
          boxShadow: [
            BoxShadow(
              color: isDisabled ? Colors.transparent : widget.shadowColor,
              offset: Offset(0, isDisabled || _isPressed ? 0 : widget.shadowOffset),
              blurRadius: 0,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
