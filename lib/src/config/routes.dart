import 'package:flutter/material.dart';

import './app_constants.dart' as app_constants;
import '../screens/crypto_detail_screen.dart';
import '../screens/search_screen.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    app_constants.RouteNames.cryptoDetail: (context) => const CryptoDetailScreen(),
    app_constants.RouteNames.searchScreen: (context) => const SearchScreen(),
  };
}