import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/models/data.dart';

import 'package:van_quang_tinh/src/widgets/categories_table.dart';

void main() {
  testWidgets('CategoriesTable have SingleChildScrollView to scrollable',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesTable(),
    ));
    final scrollableFinder = find.byType(SingleChildScrollView);
    expect(scrollableFinder, findsOneWidget);
  });

  testWidgets('CategoriesTable have DataTable to show data',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesTable(),
    ));
    final datatableFinder = find.byType(DataTable);
    expect(datatableFinder, findsOneWidget);
  });

  testWidgets('Display correctly DataTable\'s column spacing',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesTable(),
    ));
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable).columnSpacing,
        18.0);
  });

  testWidgets('Display correctly DataTable\'s horizontal margin',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesTable(),
    ));
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .horizontalMargin,
        10.0);
  });

  testWidgets('Display correctly DataTable\'s data row height',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesTable(),
    ));
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable).dataRowHeight,
        53.5);
  });

  testWidgets('Display correctly DataTable\'s heading row height',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesTable(),
    ));
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .headingRowHeight,
        50.0);
  });

  testWidgets('DataTable have 4 columns', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesTable(),
    ));
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .columns
            .length,
        4);
  });

  testWidgets('DataTable have the same number of rows as the number of data',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CategoriesTable(),
    ));
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable).rows.length,
        data.length);
  });

}
