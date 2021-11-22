import 'package:flutter/material.dart';

import '../config/app_constants.dart';
import '../models/data.dart';
import '../utils/custom_number_format.dart';
import '../widgets/heading_row.dart';
import '../constants/constants.dart' as constants;

class CryptoCurrencyScreen extends StatefulWidget {
  const CryptoCurrencyScreen({Key? key}) : super(key: key);

  @override
  State<CryptoCurrencyScreen> createState() => _CryptoCurrencyScreenState();
}

class _CryptoCurrencyScreenState extends State<CryptoCurrencyScreen>
    with AutomaticKeepAliveClientMixin {
  final double _columnSpacing = 18;
  final double _horizontalMargin = 2;
  final double _dataRowHeight = 50;
  final double _headingRowHeight = 50;
  final double _widthOfImage = 20;
  final double _heightOfImage = 20;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: DataTable(
            showCheckboxColumn: false,
            columnSpacing: _columnSpacing,
            horizontalMargin: _horizontalMargin,
            headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
            dataRowHeight: _dataRowHeight,
            headingRowHeight: _headingRowHeight,
            headingTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800),
            columns: constants.CryptoCurrencyScreen.cryptoCurrencyHeadingColumns
                .map((column) => DataColumn(
                        label: HeadingRow(
                      title: column,
                    )))
                .toList(),
            rows: dataCrypto
                .map((model) => DataRow(
                        onSelectChanged: (_) {
                          Navigator.of(context)
                              .pushNamed(RouteNames.cryptoDetail, arguments: {
                            constants.CryptoCurrencyScreen.idArgument: model.id
                          });
                        },
                        cells: [
                          DataCell(Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${model.marketCapRank}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ))),
                          DataCell(Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  model.image,
                                  width: _widthOfImage,
                                  height: _heightOfImage,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  model.symbol.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )),
                          DataCell(Align(
                              alignment: Alignment.centerRight,
                              child: Text('\$ ${model.currentPrice}',
                                  style:
                                      Theme.of(context).textTheme.subtitle2))),
                          DataCell(Align(
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
                          )),
                          DataCell(Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  '\$ ${CustomNumberFormat.customNumberFormatWithoutDots(model.marketCap)}',
                                  style:
                                      Theme.of(context).textTheme.subtitle2))),
                        ]))
                .toList()),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
