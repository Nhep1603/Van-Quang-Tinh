import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../constants/constants.dart' as constants;

class CryptoDetailScreen extends StatelessWidget {
  const CryptoDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(constants.CryptoDetailScreen.toolbarHeight),
        child: CustomAppBar(
          icondata: Icons.arrow_back_ios_rounded,
          symbolImagePath: constants.CryptoDetailScreen.symbolImagePath,
          titleAppBar: constants.CryptoDetailScreen.titleAppBar,
        ),
      ),
    );
  }
}
