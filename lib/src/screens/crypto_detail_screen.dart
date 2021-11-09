import 'package:flutter/material.dart';

import '../constants/constants.dart' as constant;

class CryptoDetailScreen extends StatelessWidget {
  const CryptoDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double toolbarHeight = 70.0;
    double backButtonHeight = toolbarHeight * .4;
    double backButtonAndSymbolImageSpacing = 50.0;
    double symbolImageWidth = 40.0;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: backButtonHeight,
          ),
          onPressed: () {},
          splashRadius: backButtonHeight / 1.5,
        ),
        actions: [
          SizedBox(
            width: backButtonAndSymbolImageSpacing,
          ),
          SizedBox(
            width: symbolImageWidth,
            child: Image.asset(
              constant.CryptoDetailScreen.symbolImage,
              scale: 2.2,
            ) ,
          ),
          Align(
            child: Text(
              constant.CryptoDetailScreen.titleAppBar,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.45,
                    color: Colors.black54,
                  ),
            ),
          ),
          const Spacer(),
        ],
      ),
      body: const Text('data'),
    );
  }
}
