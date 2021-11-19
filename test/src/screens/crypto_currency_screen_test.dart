import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:van_quang_tinh/src/screens/crypto_currency_screen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyTypeFake extends Fake implements Route {}

void main() {
  
  var widget = const MaterialApp(
    home: CryptoCurrencyScreen(),
  );
  double columnSpacing = 18;
  double horizontalMargin = 2;
  double dataRowHeight = 50;
  double headingRowHeight = 50;

  testWidgets('CryptoCurrencyScreen have SingleChildScrollView to scrollable',
      (tester) async {
    await tester.pumpWidget(widget);

    final scrollableFinder = find.byType(SingleChildScrollView);

    expect(scrollableFinder, findsOneWidget);
  });

  testWidgets('DataTable have 5 columns', (tester) async {
    await tester.pumpWidget(widget);

    final columnsFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .columns
            .length;

    expect(columnsFinder, 5);
  });

  testWidgets('Display correctly DataTable\'s column spacing', (tester) async {
    await tester.pumpWidget(widget);

    final columnSpacingFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable).columnSpacing;

    expect(columnSpacingFinder, columnSpacing);
  });

  testWidgets('Display correctly DataTable\'s horizontal margin',
      (tester) async {
    await tester.pumpWidget(widget);

    final horizontalMarginFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .horizontalMargin;

    expect(horizontalMarginFinder, horizontalMargin);
  });

  testWidgets('Display correctly DataTable\'s data row height', (tester) async {
    await tester.pumpWidget(widget);

    final dataRowHeightFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable).dataRowHeight;

    expect(dataRowHeightFinder, dataRowHeight);
  });

  testWidgets('Display correctly DataTable\'s heading row height',
      (tester) async {
    await tester.pumpWidget(widget);

    final headingRowHeightFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .headingRowHeight;

    expect(headingRowHeightFinder, headingRowHeight);
  });

  testWidgets('DataTable have the same number of rows as the number of data',
      (tester) async {
    await tester.pumpWidget(widget);

    final rowsFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable).rows.length;

    expect(rowsFinder, 4);
  });
}
