import 'package:flutter/material.dart';

class HeadingRow extends StatelessWidget {
  final String title;

  const HeadingRow({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Text(title),
    ));
  }
}
