import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:van_quang_tinh/src/widgets/currency_conversion_text_field.dart';
import 'package:van_quang_tinh/src/widgets/text_with_border.dart';

void main() {
  group('CurrencyConversionTextField of ETH Tests', () {
    bool isChanged = false;
    var widget = MaterialApp(
        home: Scaffold(
      body: CurrencyConverSionTextField(
        labelText: 'ETH',
        onChanged: (value) => isChanged = true,
      ),
    ));

    testWidgets('Should render a TextField widget', (tester) async {
      await tester.pumpWidget(widget);

      final textFieldFinder = find.descendant(
        of: find.byType(CurrencyConverSionTextField),
        matching: find.byType(TextField),
      );

      expect(textFieldFinder, findsOneWidget);
    });

    testWidgets('Should render a Text widget', (tester) async {
      await tester.pumpWidget(widget);

      final textFinder = find.descendant(
        of: find.byType(CurrencyConverSionTextField),
        matching: find.text('ETH'),
      );

      expect(textFinder, findsOneWidget);
    });

    testWidgets('CurrencyConversionTextField should be changed',
        (tester) async {
      await tester.pumpWidget(widget);

      await tester.enterText(find.byType(TextField), '1');

      expect(isChanged, true);
    });
  });

  group('CurrencyConversionTextField of USD Tests', () {
    bool isChanged = false;
    var widget = MaterialApp(
        home: Scaffold(
      body: CurrencyConverSionTextField(
        labelText: 'USD',
        currentCryptoPrice: 66852,
        isCrypto: false,
        onChanged: (value) => isChanged = true,
      ),
    ));

    testWidgets('Should render a TextField widget', (tester) async {
      await tester.pumpWidget(widget);

      final textFieldFinder = find.descendant(
        of: find.byType(CurrencyConverSionTextField),
        matching: find.byType(TextField),
      );

      expect(textFieldFinder, findsOneWidget);
    });

    testWidgets('Should render a TextWithBorder widget', (tester) async {
      await tester.pumpWidget(widget);

      final textFinder = find.descendant(
        of: find.byType(CurrencyConverSionTextField),
        matching: find.byType(TextWithBorder),
      );

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Should render a Text widget', (tester) async {
      await tester.pumpWidget(widget);

      final textFinder = find.descendant(
        of: find.byType(CurrencyConverSionTextField),
        matching: find.text('USD'),
      );

      expect(textFinder, findsOneWidget);
    });

    testWidgets('CurrencyConversionTextField should be changed',
        (tester) async {
      await tester.pumpWidget(widget);

      await tester.enterText(find.byType(TextField), '1');

      expect(isChanged, true);
    });
  });
}
