import 'package:flutter/material.dart';

class ShadowContainerWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double? padding;
  final AlignmentGeometry? textAlignment;

  const ShadowContainerWidget({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 10,
    this.textAlignment,
    this.padding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 420,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(50, 50, 93, 0.25),
            blurRadius: 5,
            spreadRadius: -1,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            blurRadius: 3,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Align(
        alignment: textAlignment ?? Alignment.centerLeft,
        child: child,
      ),
    );
  }
}
