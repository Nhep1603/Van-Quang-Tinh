import 'package:flutter/material.dart';

import '../utils/custom_number_format.dart';
import './text_with_border.dart';

class CurrencyConverSionTextField extends StatelessWidget {
  const CurrencyConverSionTextField({
    Key? key,
    required this.labelText,
    this.isCrypto = true,
    this.onChanged,
    this.currentCryptoPrice,
  }) : super(key: key);

  final String labelText;
  final bool isCrypto;
  final ValueChanged<String>? onChanged;
  final double? currentCryptoPrice;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChanged!(value),
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: isCrypto && currentCryptoPrice == null
            ? CustomNumberFormat.customNumberFormatWithoutCommas.format(1)
            : CustomNumberFormat.customNumberFormatWithoutCommas
                .format(currentCryptoPrice),
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.grey.shade700,
              fontSize: 16.0,
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
