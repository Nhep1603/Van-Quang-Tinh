import 'package:flutter/material.dart';

class TextWithBorder extends StatelessWidget {
  const TextWithBorder({
    Key? key,
    required this.text,
    required this.textColor,
    required this.boxColor,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 9.0,
      ),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
      ),
    );
  }
}