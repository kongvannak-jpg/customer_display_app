import 'package:flutter/material.dart';

class TitleLgWidget extends StatelessWidget {
  final String text;
  const TitleLgWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
