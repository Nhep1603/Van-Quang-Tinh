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

  static const cryptoCurrencyHeadingColumns = [
    numberHeading,
    coinHeading,
    priceHeading,
    priceChangeHeading,
    marketCapHeading
  ];
}

class CryptoDetailScreen {
  static const double toolbarHeight = 70.0;
  static const double lineChartHeight = 200.0;
  static const double emojiLargeImageHeight = 55.0;
  static const double emojiSmallImageHeight = 35.0;
  static const double priceChangePercentage24h = -0.5;
  static const double currentPrice = 62614;
  
  static const String symbolImagePath = 'assets/images/bitcoin_symbol.jpg';
  static const String logoImagePath = 'assets/images/coingecko_logo.png';
  static const String sadEmojiImagePath = 'assets/images/sad_emoji.png';
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
  static const Color criptoPriceLineChartFlLineColor = Color(0xffcfd8dc);

  static const List<Color> criptoPriceLineChartGradientColors = [
    Color(0xffffffff),
    Color(0xffffffff),
    Color(0xff01579b),
  ];
  static const List<Color> criptoPriceLineChartGradientColorsLine = [
    Color(0xff01579b),
  ];
}
