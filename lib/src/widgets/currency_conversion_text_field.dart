import 'package:flutter/material.dart';

import './text_with_border.dart';

class CurrencyConverSionTextField extends StatelessWidget {
  const CurrencyConverSionTextField({
    Key? key,
    required this.labelText,
    this.isCrypto = true,
    this.onChanged,
    this.hintext,
    this.controller,
  }) : super(key: key);

  final String labelText;
  final bool isCrypto;
  final ValueChanged<String>? onChanged;
  final String? hintext;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) => onChanged!(value),
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintext,
        hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
        icon: isCrypto
            ? Text(
                labelText,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
              )
            : TextWithBorder(
                text: labelText,
                textColor: Colors.grey.shade800,
                boxColor: Colors.grey.shade200,
              ),
        constraints: const BoxConstraints(
          minHeight: 40.0,
          maxHeight: 40.0,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
