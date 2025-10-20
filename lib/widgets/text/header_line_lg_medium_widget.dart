import 'package:flutter/material.dart';

class HeaderLineLgMediumWidget extends StatelessWidget {
  final String text;
  const HeaderLineLgMediumWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
