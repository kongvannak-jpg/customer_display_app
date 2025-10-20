import 'package:flutter/material.dart';

class TitleLgSemiboldWidget extends StatelessWidget {
  final String text;
  const TitleLgSemiboldWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
