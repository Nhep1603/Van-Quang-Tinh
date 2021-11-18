import 'package:flutter/material.dart';

class HomeScreen {
  static const String cryptoCurrency = 'Cryptocurrency';
  static const String categories = 'Categories';
  static const String logoLink = "assets/images/logo.png";
  static const int searchButtonColor = 0xff4b4b4b;
}

class CategoriesScreen {}

class CryptoCurrencyScreen {}

class CryptoDetailScreen {
  static const double toolbarHeight = 70.0;
  static const double lineChartHeight = 200.0;
  static const double emojiLargeImageHeight = 55.0;
  static const double emojiSmallImageHeight = 35.0;

  static const double priceChangePercentage24h = -0.5;
  static const double currentPrice = 62614;

  static const String symbolImagePath = 'assets/images/bitcoin_symbol.jpg';
  static const String logoImagePath = 'assets/images/coingecko_logo.png';
  static const String sadlyEmojiImagePath = 'assets/images/sadly_emoji.png';
  static const String smileEmojiImagePath = 'assets/images/smile_emoji.png';
  static const String titleAppBar = 'Bitcoin (BTC)';
  static const String bitcoinSymbol = 'BTC';
  static const String usd = 'USD';
  static const String lineChartName = 'Price';
  static const String button24Hours = '24H';
  static const String button7Days = '7D';
  static const String cryptoTitleVote = 'How do you feel about Bitcoin today?';
  static const String thanksForYourVote = 'Thanks for your vote!';
  static const String titleLineChart7D = 'Line Chart 7D';
}

class ColorConstants {
  static const colorOfTextAndIndicator = Color(0xff8FC746);
}
