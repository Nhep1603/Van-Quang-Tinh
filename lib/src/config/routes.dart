import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../screens/crypto_currency_screen.dart';
import '../screens/home_screen.dart';
import './app_constants.dart' as app_constants;
import '../screens/crypto_detail_screen.dart';
import '../screens/search_screen.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case app_constants.RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case app_constants.RouteNames.cryptoCurrency:
        return MaterialPageRoute(
          builder: (_) => const CryptoCurrencyScreen(),
        );
      case app_constants.RouteNames.categories:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
        );
      case app_constants.RouteNames.cryptoDetail:
        return MaterialPageRoute(
          builder: (_) => CryptoDetailScreen(settings.arguments as String),
        );
      case app_constants.RouteNames.searchScreen:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      default:
        throw Exception();
    }
  }
}
