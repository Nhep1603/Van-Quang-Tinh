import 'package:flutter/material.dart';
import 'package:van_quang_tinh/src/utils/custom_number_format.dart';

import './text_with_border.dart';

class CurrencyConverSionTextField extends StatelessWidget {
  const CurrencyConverSionTextField({
    Key? key,
    required this.labelText,
    this.isCrypto = true,
    this.onChanged,
    this.currentPrice,
  }) : super(key: key);

  final String labelText;
  final bool isCrypto;
  final VoidCallback? onChanged;
  final int? currentPrice;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        textAlign: TextAlign.right,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: isCrypto
              ? CustomNumberFormat.customNumberFormatWithoutCommas.format(1)
              : CustomNumberFormat.customNumberFormatWithoutCommas
                  .format(currentPrice),
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
        onChanged: (value) => onChanged!(),
      ),
    );
  }
}
