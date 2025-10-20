import 'package:flutter/material.dart';

class TitleMdWidget extends StatelessWidget {
  final String text;
  const TitleMdWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
