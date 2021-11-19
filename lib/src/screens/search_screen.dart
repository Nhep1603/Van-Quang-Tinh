import 'package:flutter/material.dart';

import '../constants/constants.dart' as constant;
import '../models/crypto.dart';
import '../widgets/coin_search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, this.dataCrypto}) : super(key: key);

  final List<Crypto>? dataCrypto;

  @override
  Widget build(BuildContext context) {
    double toolBarSize = MediaQuery.of(context).size.height * .1;
    double iconSize = MediaQuery.of(context).size.height * .035;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: toolBarSize,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: iconSize, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              constant.SearchScreen.title,
              style: TextStyle(color: Colors.black),
            )),
        body: CoinSearch(dataCrypto: dataCrypto));
  }
}
