import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/screens/crypto_detail_screen.dart';
import 'package:van_quang_tinh/src/constants/constants.dart' as constants;

void main() {
  group('AppBar of Crypto Detail Screen Tests', () {
    var widget = const MaterialApp(home: CryptoDetailScreen());

    testWidgets('Should render Appbar with PreferredSize widget.',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final preferredSizeWidgetFinder = find.byType(PreferredSize);

      expect(preferredSizeWidgetFinder, findsOneWidget);
    });

    testWidgets('Should render Appbar with correct title.',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final titleFinder = find.descendant(
          of: find.byType(AppBar),
          matching: find.text(constants.CryptoDetailScreen.titleAppBar));

      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Should render AppBar with a image.',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final imageFinder = find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(Image),
      );

      expect(imageFinder, findsOneWidget);
    });

    testWidgets('Should render Appbar with a arrow_back_ios_rounded button.',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final iconButtonFinder = find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(IconButton),
      );

      expect(iconButtonFinder, findsOneWidget);

      final iconFinder = find.byIcon(Icons.arrow_back_ios_rounded);

      expect(iconFinder, findsOneWidget);
    });
  });
}
