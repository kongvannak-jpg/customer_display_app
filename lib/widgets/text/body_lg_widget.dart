import 'package:flutter/material.dart';

class BodyLgWidget extends StatelessWidget {
  final String text;
  const BodyLgWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
