import 'package:flutter/material.dart';

import './app_constants.dart' as app_constants;
import '../screens/categories_screen.dart';
import '../screens/crypto_currency_screen.dart';
import '../screens/crypto_detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    app_constants.RouteNames.home: (context) => const HomeScreen(),
    app_constants.RouteNames.cryptoCurrency: (context) => const CryptoCurrencyScreen(),
    app_constants.RouteNames.categories: (context) => const CategoriesScreen(),
    app_constants.RouteNames.cryptoDetail: (context) => const CryptoDetailScreen(),
    app_constants.RouteNames.searchScreen: (context) => const SearchScreen(),
  };
}