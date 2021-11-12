import 'package:flutter/material.dart';

import '../constants/constants.dart' as constants;
import '../screens/crypto_currency_screen.dart' as crypto;
import '../screens/categories_screen.dart' as category;

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double logoSize = MediaQuery.of(context).size.height * .13;
    double toolBarSize = MediaQuery.of(context).size.height * .11;
    double iconSize = MediaQuery.of(context).size.height * .04;
    final _tabs = [
      constants.HomeScreen.cryptoCurrency,
      constants.HomeScreen.categories
    ];

    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
             elevation: 0,
        centerTitle: true,
        toolbarHeight: toolBarSize,
        backgroundColor: Colors.white,
        title: Image.asset(constants.HomeScreen.logoLink,height: logoSize,), 
        actions: <Widget>[
            IconButton(
            alignment: const Alignment(-3, 0),
            iconSize: iconSize,
            color: const Color(constants.HomeScreen.searchButtonColor),
            icon: const Icon(Icons.search),
            onPressed: onPressed,
          ),
        ],
            bottom: TabBar(
                labelColor: constants.ColorConstants.colorOfTextAndIndicator,
                unselectedLabelColor: Colors.black,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                indicatorColor: constants.ColorConstants.colorOfTextAndIndicator,
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
