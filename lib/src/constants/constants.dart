import 'package:flutter/material.dart';

class HomeScreen {
  static const String cryptoCurrency = 'Cryptocurrency';
  static const String categories = 'Categories';
  static const String logoLink = "assets/images/logo.png";
  static const int searchButtonColor = 0xff4b4b4b;
}

class CategoriesScreen {}

class CryptoCurrencyScreen {
  static const String numberHeading = '#';
  static const String coinHeading = 'Coin';
  static const String priceHeading = 'Price';
  static const String priceChangeHeading = '24H';
  static const String marketCapHeading = 'Market Cap';
  static const String idArgument = 'id';
}

class CryptoDetailScreen {
  static const double toolbarHeight = 70.0;
  static const double priceChangePercentage24h = -0.5;
  static const double currentPrice = 62614;

  static const String symbolImagePath = 'assets/images/bitcoin_symbol.jpg';
  static const String titleAppBar = 'Bitcoin (BTC)';
  static const String bitcoinSymbol = 'BTC';
  static const String usd = 'USD';
}

class ColorConstants {
  static const colorOfTextAndIndicator = Color(0xff8FC746);
}
