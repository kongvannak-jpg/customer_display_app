import 'package:flutter/material.dart';

class BtnHoverPrimaryWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const BtnHoverPrimaryWidget({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0), // no shadow
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.hovered)) {
            return Theme.of(context).colorScheme.primaryContainer;
          }
          if (states.contains(WidgetState.pressed)) {
            return Theme.of(context).colorScheme.inversePrimary;
          }
          return Colors.transparent; // default: no background
        }),
        shape: WidgetStateProperty.all(CircleBorder()),
        padding: WidgetStateProperty.all(const EdgeInsets.all(16)),
      ),
      child: Icon(
        icon,
        size: 25,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
