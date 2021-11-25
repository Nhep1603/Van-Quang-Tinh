import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';
import '../config/app_constants.dart';
import '../constants/constants.dart' as constant;
import '../models/crypto.dart';
import '../widgets/load_failure.dart';

class CoinSearch extends StatelessWidget {
  const CoinSearch({Key? key}) : super(key: key);

  static String displayStringForOption(Crypto option) => option.name;

  @override
  Widget build(BuildContext context) {
    double optionsViewBuilderwidth = MediaQuery.of(context).size.width * 0.9;
    double containerMargin = MediaQuery.of(context).size.height * .0275;
    BlocProvider.of<SearchBloc>(context).add(SearchRequested());

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchLoadFailure) {
          return LoadFailure(reload: () {
            context.read<SearchBloc>().add(SearchRequested());
          });
        } else if (state is SearchLoadSuccess) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: containerMargin),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Autocomplete<Crypto>(
              displayStringForOption: displayStringForOption,
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
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 18),
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<Crypto>.empty();
                }
                return state.cryptos!.where((Crypto option) {
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
                            Navigator.pushNamed(
                                context, RouteNames.cryptoDetail,
                                arguments: option.id);
                          },
                          child: Card(
                            child: ListTile(
                              leading: Image.network(
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
        return Container(
          color: Colors.orange,
        );
      },
    );
  }
}
