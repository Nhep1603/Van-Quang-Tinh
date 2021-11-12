import 'package:flutter/material.dart';

import '../constants/constants.dart' as constants;
import '../models/data.dart';

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
              child: Text(constants.CategoriesScreen.cloumn1Name),
            ))),
            DataColumn(
                label: Expanded(
                    child: Center(
              child: Text(constants.CategoriesScreen.cloumn2Name),
            ))),
            DataColumn(
                label: Expanded(
                    child: Center(
              child: Text(constants.CategoriesScreen.cloumn3Name),
            ))),
            DataColumn(
                label: Expanded(
                    child: Center(
              child: Text(constants.CategoriesScreen.cloumn4Name),
            ))),
          ],
          rows: data
              .map((model) => DataRow(cells: [
                    DataCell(Align(
                        alignment: Alignment.center,
                        child: Text(
                          model.id!,
                          style: constants.CategoriesScreen.columnIDTextStyle,
                        ))),
                    DataCell(Align(
                        alignment: Alignment.centerLeft,
                        child: Text(model.name!,
                            style: constants
                                .CategoriesScreen.columnNameTextStyle))),
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text(
                        model.marketCapChange24h!.toStringAsFixed(1) + '%',
                        style: TextStyle(
                            color: model.marketCapChange24h! > 0
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                    DataCell(Align(
                        alignment: Alignment.centerLeft,
                        child: Text('\$' + model.marketCap!.toStringAsFixed(0),
                            style: constants
                                .CategoriesScreen.columnMarketCapTextStyle))),
                  ]))
              .toList()),
    );
  }
}
