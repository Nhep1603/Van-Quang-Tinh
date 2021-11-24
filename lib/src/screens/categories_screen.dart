import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:van_quang_tinh/src/widgets/load_failure.dart';

import '../blocs/category/category_bloc.dart';
import '../blocs/category/category_event.dart';
import '../blocs/category/category_state.dart';
import '../constants/constants.dart' as constants;
import '../utils/custom_number_format.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    int serialNumber = 0;
    context.read<CategoryBloc>().add(CategoryRequested());
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoadSucess) {
          return RefreshIndicator(
            onRefresh: () async {
              serialNumber = 0;
              context.read<CategoryBloc>().add(CategoryRequested());
            },
            child: SingleChildScrollView(
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
                  rows: state.categories!
                      .map((model) => DataRow(cells: [
                            DataCell(Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (++serialNumber).toString(),
                                  style: constants
                                      .CategoriesScreen.columnIDTextStyle,
                                ))),
                            DataCell(Align(
                                alignment: Alignment.centerLeft,
                                child: Text(model.name,
                                    style: constants.CategoriesScreen
                                        .columnNameTextStyle))),
                            DataCell(Align(
                              alignment: Alignment.center,
                              child: model.marketCapChange24h != 0
                                  ? Text(
                                      model.marketCapChange24h
                                              .toStringAsFixed(1) +
                                          '%',
                                      style: TextStyle(
                                          color: model.marketCapChange24h > 0
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : const Center(
                                      child: Text(
                                      constants.StringConstant
                                          .textForMarketCapFieldEqualsZero,
                                      style: TextStyle(fontSize: 25),
                                    )),
                            )),
                            DataCell(Align(
                                alignment: Alignment.centerLeft,
                                child: model.marketCap != 0
                                    ? Text(
                                        '\$${CustomNumberFormat.customNumberFormatWithoutDots(model.marketCap)}',
                                        style: constants.CategoriesScreen
                                            .columnMarketCapTextStyle)
                                    : const Center(
                                        child: Text(
                                        constants.StringConstant
                                            .textForMarketCapFieldEqualsZero,
                                        style: TextStyle(fontSize: 25),
                                      )))),
                          ]))
                      .toList()),
            ),
          );
        } else if (state is CategoryLoadFailure) {
          return LoadFailure(reload: () {
            context.read<CategoryBloc>().add(CategoryRequested());
          });
        }
        return Container(
          color: Colors.green,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
