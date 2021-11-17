import 'package:flutter/material.dart';

import '../config/app_constants.dart';
import '../constants/constants.dart' as constant;
import '../models/crypto.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, this.dataCrypto}) : super(key: key);

  final List<Crypto>? dataCrypto;

  static String _displayStringForOption(Crypto option) => option.name!;

  @override
  Widget build(BuildContext context) {
    double optionsViewBuilderwidth = MediaQuery.of(context).size.width * 0.9;
    double toolBarSize = MediaQuery.of(context).size.height * .1;
    double iconSize = MediaQuery.of(context).size.height * .035;
    double containerMargin = MediaQuery.of(context).size.height * .0275;

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
      body: Container(
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
              style: const TextStyle(color: Colors.black, fontSize: 18),
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
                            option.image!,
                            errorBuilder: (context, error, strackTrace) =>
                                const Icon(Icons.error),
                          ),
                          title: Text(
                            option.name!,
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
      ),
    );
  }
}
