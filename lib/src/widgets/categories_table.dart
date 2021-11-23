import 'package:flutter/material.dart';

import '../constants/constants.dart' as constants;
import '../models/data.dart';
import '../utils/custom_number_format.dart';

class CategoriesTable extends StatelessWidget {
  const CategoriesTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
          columnSpacing: constants.CategoriesScreen.columnSpacing,
          horizontalMargin: constants.CategoriesScreen.horizontalMargin,
          headingTextStyle: constants.CategoriesScreen.headingTextStyle,
          headingRowColor: MaterialStateProperty.all(
              constants.CategoriesScreen.headingRowColor),
          dataRowColor: MaterialStateProperty.all(
              constants.CategoriesScreen.dataRowColor),
          dataRowHeight: constants.CategoriesScreen.dataRowHeight,
          headingRowHeight: constants.CategoriesScreen.headingRowHeight,
          columns: const [
            DataColumn(
                label: Expanded(
                    child: Center(
              child: Text(constants.CategoriesScreen.columnNumber),
            ))),
            DataColumn(
                label: Expanded(
                    child: Center(
              child: Text(constants.CategoriesScreen.columnCategory),
            ))),
            DataColumn(
                label: Expanded(
                    child: Center(
              child: Text(constants.CategoriesScreen.columnTime),
            ))),
            DataColumn(
                label: Expanded(
                    child: Center(
              child: Text(constants.CategoriesScreen.columnMarketCap),
            ))),
          ],
          rows: data
              .map((model) => DataRow(cells: [
                    DataCell(Align(
                        alignment: Alignment.center,
                        child: Text(
                          model.id,
                          style: constants.CategoriesScreen.columnIDTextStyle,
                        ))),
                    DataCell(Align(
                        alignment: Alignment.centerLeft,
                        child: Text(model.name,
                            style: constants
                                .CategoriesScreen.columnNameTextStyle))),
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: model.marketCapChange24h != 0
                          ? Text(
                              model.marketCapChange24h.toStringAsFixed(1) + '%',
                              style: TextStyle(
                                  color: model.marketCapChange24h > 0
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.w500),
                            )
                          : const Center(
                              child: Text(
                              constants.CategoriesScreen.checkEqualZeroText,
                              style: TextStyle(fontSize: 25),
                            )),
                    )),
                    DataCell(Align(
                        alignment: Alignment.centerLeft,
                        child: model.marketCap != 0
                            ? Text(
                                '\$${CustomNumberFormat.customNumberFormatWithCommasAndHaveNoSurplus(model.marketCap)}',
                                style: constants
                                    .CategoriesScreen.columnMarketCapTextStyle)
                            : const Center(
                                child: Text(
                                constants.CategoriesScreen.checkEqualZeroText,
                                style: TextStyle(fontSize: 25),
                              )))),
                  ]))
              .toList()),
    );
  }
}
