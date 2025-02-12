import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, danger, transparent }

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isDisabled;
  final IconData? icon;
  final bool isFullWidth;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isDisabled = false,
    this.isFullWidth = false,
    this.icon,
  });

  Color _getBackgroundColor(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return Colors.blue;
      case ButtonType.secondary:
        return Colors.grey;
      case ButtonType.transparent:
        return Colors.white.withAlpha(0);
      case ButtonType.danger:
        return Colors.red;
    }
  }

  Color _getTextColor(BuildContext context) {
    return type == ButtonType.transparent ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: TextButton.styleFrom(
          backgroundColor:
              isDisabled ? Colors.grey.shade400 : _getBackgroundColor(context),
          foregroundColor: _getTextColor(context),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
