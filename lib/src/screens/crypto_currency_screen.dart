import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/crypto_currency/bloc/crypto_currency_state.dart';
import '../blocs/crypto_currency/bloc/crypto_currency_bloc.dart';
import '../blocs/crypto_currency/bloc/crypto_currency_event.dart';
import '../config/app_constants.dart';
import '../constants/constants.dart' as constants;
import '../utils/custom_number_format.dart';
import '../widgets/heading_row.dart';

class CryptoCurrencyScreen extends StatefulWidget {
  const CryptoCurrencyScreen({Key? key}) : super(key: key);

  @override
  State<CryptoCurrencyScreen> createState() => _CryptoCurrencyScreenState();
}

class _CryptoCurrencyScreenState extends State<CryptoCurrencyScreen>
    with AutomaticKeepAliveClientMixin {
  final double _columnSpacing = 4;
  final double _horizontalMargin = 5;
  final double _dataRowHeight = 55;
  final double _headingRowHeight = 50;
  final double _widthOfImage = 20;
  final double _heightOfImage = 20;
  final double _widthOfCellMarketRank = 25;
  final double _widthOfCellCoin = 70;
  final double _widthOfCellPrice = 100;
  final double _widthOfCellPriceChange = 45;

  @override
  void initState() {
    super.initState();
    context.read<CryptoCurrencyBloc>().add(CryptoCurrencyRequested());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<CryptoCurrencyBloc, CryptoCurrencyState>(
        builder: (context, state) {
          if (state is CryptoCurrencyLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CryptoCurrencyLoadFailure) {
            return Container(
              color: Colors.red,
              alignment: Alignment.center,
              child: Text(state.errorMessage!),
            );
          } else if (state is CryptoCurrencyLoadSucess) {
            if (state.cryptos != null) {
              return RefreshIndicator(
                onRefresh: () async => context
                    .read<CryptoCurrencyBloc>()
                    .add(CryptoCurrencyRequested()),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DataTable(
                          showCheckboxColumn: false,
                          columnSpacing: _columnSpacing,
                          horizontalMargin: _horizontalMargin,
                          headingRowColor:
                              MaterialStateProperty.all(Colors.grey.shade200),
                          dataRowHeight: _dataRowHeight,
                          headingRowHeight: _headingRowHeight,
                          headingTextStyle: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                          columns: constants
                              .CryptoCurrencyScreen.cryptoCurrencyHeadingColumns
                              .map((column) => DataColumn(
                                      label: HeadingRow(
                                    title: column,
                                  )))
                              .toList(),
                          rows: state.cryptos!
                              .map((model) => DataRow(
                                      onSelectChanged: (_) {
                                        Navigator.of(context).pushNamed(
                                            RouteNames.cryptoDetail,
                                            arguments: {
                                              constants.CryptoCurrencyScreen
                                                  .idArgument: model.id
                                            });
                                      },
                                      cells: [
                                        DataCell(SizedBox(
                                          width: _widthOfCellMarketRank,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${model.marketCapRank}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              )),
                                        )),
                                        DataCell(SizedBox(
                                          width: _widthOfCellCoin,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  model.image,
                                                  width: _widthOfImage,
                                                  height: _heightOfImage,
                                                ),
                                                const SizedBox(height: 3),
                                                Text(model.symbol.toUpperCase(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                              ],
                                            ),
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width: _widthOfCellPrice,
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  '\$${model.currentPrice}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                        )),
                                        DataCell(SizedBox(
                                          width: _widthOfCellPriceChange,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${model.priceChangePercentage24h.toStringAsFixed(1)}%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontSize: 15,
                                                      color: model.priceChangePercentage24h
                                                                  .toDouble() >
                                                              0
                                                          ? Colors.green
                                                          : Colors.red),
                                            ),
                                          ),
                                        )),
                                        DataCell(Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                '\$${CustomNumberFormat.customNumberFormatWithoutDots(model.marketCap)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold))))
                                      ]))
                              .toList()),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('Crypto is NULL'));
            }
          }
          return Container(
            color: Colors.orange,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
