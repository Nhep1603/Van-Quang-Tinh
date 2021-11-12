import 'package:flutter/material.dart';

class HomeScreen {
  static const String cryptoCurrency = 'Cryptocurrency';
  static const String categories = 'Categories';
  static const String logoLink = "assets/images/coingecko_logo.png";
  static const int searchButtonColor = 0xff4b4b4b;
}

class CategoriesScreen {
  static const String cloumn1Name = '#';
  static const String cloumn2Name = 'Category';
  static const String cloumn3Name = '24H';
  static const String cloumn4Name = 'Market Cap';

  static const double columnSpacing = 18.0;
  static const double horizontalMargin = 10.0;
  static const double dataRowHeight = 53.5;
  static const double headingRowHeight = 50.0;

  static const Color headingRowColor = Color(0xfff9f9f9);
  static const Color dataRowColor = Color(0xffffffff);

  static const TextStyle headingTextStyle =
      TextStyle(color: Color(0xff4c4c4c), fontWeight: FontWeight.w500);
  static const TextStyle columnIDTextStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
  static const TextStyle columnNameTextStyle = TextStyle(
      color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14.2);
  static const TextStyle columnMarketCapTextStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15);
}

class CryptoCurrencyScreen {}

class CryptoDetailScreen {
  static const double toolbarHeight = 70.0;

  static const String symbolImagePath = 'assets/images/bitcoin_symbol.jpg';
  static const String titleAppBar = 'Bitcoin (BTC)';
}

class ColorConstants {
  static const colorOfTextAndIndicator = Color(0xff8FC746);
}
