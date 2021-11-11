import 'package:flutter/material.dart';

import '../constants/constants.dart' as constants;

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double logoSize = MediaQuery.of(context).size.height * .13;
    double toolBarSize = MediaQuery.of(context).size.height * .11;
    double iconSize = MediaQuery.of(context).size.height * .04;

    return Scaffold(
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
        ]
      ), 
    );
  }
}
