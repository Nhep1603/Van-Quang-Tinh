import 'package:flutter/material.dart';

import '../constants/constants.dart' as constants;
import '../screens/crypto_currency_screen.dart' as crypto;
import '../screens/categories_screen.dart' as category;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      constants.HomeScreen.cryptoCurrency,
      constants.HomeScreen.categories
    ];

    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
                labelColor: constants.HomeScreen.colorOfTextAndIndicator,
                unselectedLabelColor: Colors.black,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                indicatorColor: constants.HomeScreen.colorOfTextAndIndicator,
                tabs: _tabs
                    .map((tab) => Tab(
                          text: tab,
                        ))
                    .toList()),
          ),
          body: const TabBarView(
            children: [
              crypto.CryptoCurrencyScreen(),
              category.CategoriesScreen()
            ],
          ),
        ));
  }
}
