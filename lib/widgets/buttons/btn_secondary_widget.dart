import 'package:flutter/material.dart';

enum ButtonWidthType { full, normal }

class BtnSecondaryWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonWidthType widthType;
  final double? customWidth;
  final double? height;
  final IconData? icon;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const BtnSecondaryWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.widthType = ButtonWidthType.normal,
    this.customWidth,
    this.height,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final containerPrimaryColor =
        backgroundColor ?? theme.colorScheme.primaryContainer;
    final onPrimaryColor = textColor ?? theme.colorScheme.inversePrimary;
    final buttonHeight = height ?? 48.0;
    final buttonBorderRadius = borderRadius ?? 8.0;
    final buttonPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0);

    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(onPrimaryColor),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, color: onPrimaryColor, size: 18),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: onPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    Widget button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: containerPrimaryColor,
        foregroundColor: onPrimaryColor,
        disabledBackgroundColor: containerPrimaryColor.withValues(alpha: 0.6),
        disabledForegroundColor: onPrimaryColor.withValues(alpha: 0.6),
        elevation: 2,
        shadowColor: containerPrimaryColor.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        padding: buttonPadding,
        minimumSize: Size(0, buttonHeight),
      ),
      child: buttonChild,
    );

    // Handle width based on widthType
    switch (widthType) {
      case ButtonWidthType.full:
        return SizedBox(width: double.infinity, child: button);
      case ButtonWidthType.normal:
        if (customWidth != null) {
          return SizedBox(width: customWidth, child: button);
        }
        return button;
    }
  }
}
