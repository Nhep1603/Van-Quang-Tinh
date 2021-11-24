import 'package:flutter/material.dart';

import '../config/app_constants.dart';
import '../constants/constants.dart' as constant;
import '../models/crypto.dart';

class CoinSearch extends StatelessWidget {
  const CoinSearch({Key? key, this.dataCrypto}) : super(key: key);

  final List<Crypto>? dataCrypto;

  static String _displayStringForOption(Crypto option) => option.name;

  @override
  Widget build(BuildContext context) {
    double optionsViewBuilderwidth = MediaQuery.of(context).size.width * 0.9;
    double containerMargin = MediaQuery.of(context).size.height * .0275;
   
    return Container(
      margin: EdgeInsets.symmetric(horizontal: containerMargin),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Autocomplete<Crypto>(
        displayStringForOption: _displayStringForOption,
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: constant.SearchScreen.hintText),
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18),
          );
        },
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<Crypto>.empty();
          }
          return dataCrypto!.where((Crypto option) {
            return option.name
                    .toString()
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()) ||
                option.symbol
                    .toString()
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
          });
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.white,
              width: optionsViewBuilderwidth,
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final Crypto option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.cryptoDetail,
                          arguments: option.id);
                    },
                    child: Card(
                      child: ListTile(
                        leading: Image.asset(
                          option.image,
                          errorBuilder: (context, error, strackTrace) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(
                          option.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
