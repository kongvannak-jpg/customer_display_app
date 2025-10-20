import 'package:customer_display_app/widgets/text/body_lg_widget.dart';
import 'package:customer_display_app/widgets/text/title_lg_widget.dart';
import 'package:flutter/material.dart';

// Constants for better maintainability
class _PopupConstants {
  static const double dialogWidth = 500.0;
  static const double iconSize = 32.0;
  static const double iconPadding = 16.0;
  static const double iconMargin = 8.0;
  static const double borderRadius = 8.0;
  static const double hoverOpacity = 0.1;
  static const double mainSpacing = 20.0;
  static const double sectionSpacing = 10.0;

  // Text content
  static const String dialogTitle = 'Create your free account';
  static const String instructionText =
      'Please download and use MyLekha Dashboard to create an account for free';
  static const String platformText = 'Choose platform';
  static const String cancelText = 'Cancel';

  // Store URLs
  static const String appleStoreUrl = 'https://www.apple.com/app-store/';
  static const String playStoreUrl = 'https://play.google.com/store';
  static const String microsoftStoreUrl = 'https://apps.microsoft.com/';
}

class StoreIconButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final double? iconSize;
  final double? padding;
  final double? margin;
  final double? borderRadius;
  final double? hoverOpacity;

  const StoreIconButton({
    super.key,
    required this.icon,
    required this.url,
    this.iconSize,
    this.padding,
    this.margin,
    this.borderRadius,
    this.hoverOpacity,
  });

  @override
  State<StoreIconButton> createState() => _StoreIconButtonState();
}

class _StoreIconButtonState extends State<StoreIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final iconSize = widget.iconSize ?? _PopupConstants.iconSize;
    final padding = widget.padding ?? _PopupConstants.iconPadding;
    final margin = widget.margin ?? _PopupConstants.iconMargin;
    final borderRadius = widget.borderRadius ?? _PopupConstants.borderRadius;
    final hoverOpacity = widget.hoverOpacity ?? _PopupConstants.hoverOpacity;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Opening: ${widget.url}')));
          },
          icon: Icon(widget.icon, size: iconSize),
          style: IconButton.styleFrom(
            backgroundColor: _isHovered
                ? Theme.of(
                    context,
                  ).colorScheme.secondary.withValues(alpha: hoverOpacity)
                : Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            padding: EdgeInsets.all(padding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateNewAccountPopupWidget {
  static Future<void> showCreateAccountPopup(
    BuildContext context, {
    double? dialogWidth,
    String? title,
    String? instructionText,
    String? platformText,
    String? cancelText,
    bool barrierDismissible = false,
  }) {
    final effectiveDialogWidth = dialogWidth ?? _PopupConstants.dialogWidth;
    final effectiveTitle = title ?? _PopupConstants.dialogTitle;
    final effectiveInstructionText =
        instructionText ?? _PopupConstants.instructionText;
    final effectivePlatformText = platformText ?? _PopupConstants.platformText;
    final effectiveCancelText = cancelText ?? _PopupConstants.cancelText;

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: TitleLgWidget(text: effectiveTitle),
          content: SizedBox(
            width: effectiveDialogWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BodyLgWidget(text: effectiveInstructionText),
                SizedBox(height: _PopupConstants.mainSpacing),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BodyLgWidget(text: effectivePlatformText),
                    SizedBox(height: _PopupConstants.sectionSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const StoreIconButton(
                          icon: Icons.apple,
                          url: _PopupConstants.appleStoreUrl,
                        ),
                        const StoreIconButton(
                          icon: Icons.android,
                          url: _PopupConstants.playStoreUrl,
                        ),
                        const StoreIconButton(
                          icon: Icons.window,
                          url: _PopupConstants.microsoftStoreUrl,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(effectiveCancelText),
            ),
          ],
        );
      },
    );
  }
}
