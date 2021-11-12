import 'package:flutter/material.dart';

import '../widgets/currency_conversion_text_field.dart';
import '../utils/custom_number_format.dart';
import '../widgets/custom_app_bar.dart';
import '../constants/constants.dart' as constants;

class CryptoDetailScreen extends StatelessWidget {
  const CryptoDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double curentPriceLeftPadding = 20.0;
    double currentPriceAndPriceChangePercentage24hSpacing = 5.0;
    double currentPriceAndCurrencyConversionSpacing = 40.0;
    double currencyConversionHorizontalPadding = 25.0;
    double syncIconHorizontalPadding = 10.0;
    double currencyConversionAndChartSpacing = 80.0;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize:
            Size.fromHeight(constants.CryptoDetailScreen.toolbarHeight),
        child: CustomAppBar(
          icondata: Icons.arrow_back_ios_rounded,
          symbolImagePath: constants.CryptoDetailScreen.symbolImagePath,
          titleAppBar: constants.CryptoDetailScreen.titleAppBar,
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: curentPriceLeftPadding,
              ),
              Text(
                '\$${CustomNumberFormat.customNumberFormatWithCommas(constants.CryptoDetailScreen.currentPrice)}',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 38.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              SizedBox(
                width: currentPriceAndPriceChangePercentage24hSpacing,
              ),
              Text(
                '${constants.CryptoDetailScreen.priceChangePercentage24h}%',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: constants
                                  .CryptoDetailScreen.priceChangePercentage24h <
                              0
                          ? Colors.red.shade300
                          : Colors.lightGreen.shade300,
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
          SizedBox(
            height: currentPriceAndCurrencyConversionSpacing,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: currencyConversionHorizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: CurrencyConverSionTextField(
                    labelText: constants.CryptoDetailScreen.bitcoinSymbol,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: syncIconHorizontalPadding),
                  child: Icon(
                    Icons.sync_alt,
                    color: Colors.lightGreen.shade300,
                  ),
                ),
                const Flexible(
                  child: CurrencyConverSionTextField(
                    labelText: constants.CryptoDetailScreen.usd,
                    isCrypto: false,
                    currentCryptoPrice: constants.CryptoDetailScreen.currentPrice,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: currencyConversionAndChartSpacing,
          ),
        ],
      ),
    );
  }
}
