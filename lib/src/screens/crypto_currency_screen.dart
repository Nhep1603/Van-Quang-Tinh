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
  final columns = [
    constants.CryptoCurrencyScreen.numberHeading,
    constants.CryptoCurrencyScreen.coinHeading,
    constants.CryptoCurrencyScreen.priceHeading,
    constants.CryptoCurrencyScreen.priceChangeHeading,
    constants.CryptoCurrencyScreen.marketCapHeading
  ];
  int? sortColumnIndex;
  bool isAscending = false;
  double columnSpacing = 18;
  double horizontalMargin = 2;
  double dataRowHeight = 50;
  double headingRowHeight = 50;
  double widthOfImage = 20;
  double heightOfImage = 20;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: DataTable(
            showCheckboxColumn: false,
            sortColumnIndex: sortColumnIndex,
            sortAscending: isAscending,
            columnSpacing: columnSpacing,
            horizontalMargin: horizontalMargin,
            headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
            dataRowHeight: dataRowHeight,
            headingRowHeight: headingRowHeight,
            headingTextStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w800),
            columns: columns
                .map((column) => DataColumn(
                        // onSort: onSort,
                        label: HeadingRow(
                      title: column,
                    )))
                .toList(),
                
            rows: dataCrypto
                .map((model) => DataRow(
                        onSelectChanged: (_) {
                          Navigator.of(context).pushNamed(
                              RouteNames.cryptoDetail,
                              arguments: {'id': model.id});
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
                                  width: widthOfImage,
                                  height: heightOfImage,
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
                                  style:Theme.of(context).textTheme.subtitle2))),
                          DataCell(Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${model.priceChangePercentage24h.toStringAsFixed(1)}%',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: model.priceChangePercentage24h.toDouble() > 0
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          )),
                          DataCell(Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  '\$ ${CustomNumberFormat.customNumberFormatWithoutDots(model.marketCap)}',
                                  style:Theme.of(context).textTheme.subtitle2))),
                        ]))
                .toList()),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  // void onSort(int columnIndex, bool ascending) {
  //   if (columnIndex == 2) {
  //     dataCrypto.sort((data1, data2) {
  //       return compareDouble(ascending, data1.currentPrice.toDouble(),
  //           data2.currentPrice.toDouble());
  //     });
  //   } else if (columnIndex == 3) {
  //     dataCrypto.sort((data1, data2) => compareDouble(
  //         ascending,
  //         data1.priceChangePercentage24h.toDouble(),
  //         data2.priceChangePercentage24h.toDouble()));
  //   } else if (columnIndex == 4) {
  //     dataCrypto.sort((data1, data2) {
  //       return compareDouble(
  //           ascending, data1.marketCap.toDouble(), data2.marketCap.toDouble());
  //     });
  //   }

  //   setState(() {
  //     sortColumnIndex = columnIndex;
  //     isAscending = ascending;
  //   });
  // }

  // int compareDouble(bool ascending, double value1, double value2) =>
  //     ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
