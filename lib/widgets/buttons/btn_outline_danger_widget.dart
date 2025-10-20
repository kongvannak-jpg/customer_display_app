import 'package:flutter/material.dart';

enum ButtonWidthType { full, normal }

class BtnOutlineDangerWidget extends StatelessWidget {
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

  const BtnOutlineDangerWidget({
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
    final hoverColor =
        backgroundColor ?? theme.colorScheme.error.withValues(alpha: 0.1);
    final errorColor = textColor ?? theme.colorScheme.error;
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
              valueColor: AlwaysStoppedAnimation<Color>(errorColor),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, color: errorColor, size: 18),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: errorColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    Widget button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        // Background color - transparent by default, shows color on hover
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered)) {
            return hoverColor; // Background color on hover
          }
          if (states.contains(WidgetState.pressed)) {
            return hoverColor.withValues(
              alpha: 0.15,
            ); // Slightly more opaque when pressed
          }
          return Colors.transparent; // Transparent by default
        }),
        // Text and icon color
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return errorColor.withValues(alpha: 0.6);
          }
          return errorColor; // Always use error color for text/icons
        }),
        // Border color
        side: WidgetStateProperty.resolveWith<BorderSide?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: errorColor.withValues(alpha: 0.6),
              width: 1.5,
            );
          }
          return BorderSide(color: errorColor, width: 1.5);
        }),
        // Shape and other properties
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius),
          ),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(buttonPadding),
        minimumSize: WidgetStateProperty.all<Size>(Size(0, buttonHeight)),
        // Remove elevation for flat outline look
        elevation: WidgetStateProperty.all<double>(0),
        // Overlay for additional hover effects
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return errorColor.withValues(alpha: 0.1);
          }
          return null;
        }),
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
