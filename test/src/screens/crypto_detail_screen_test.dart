import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/screens/crypto_detail_screen.dart';
import 'package:van_quang_tinh/src/constants/constants.dart' as constants;

void main() {
  group('Crypto Detail Screen Tests', () {
    var widget = const MaterialApp(home: CryptoDetailScreen());

    testWidgets('Should render Appbar.',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final titleFinder = find.descendant(
          of: find.byType(AppBar),
          matching: find.text(constants.CryptoDetailScreen.titleAppBar));

      expect(titleFinder, findsOneWidget);

      final imageFinder = find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(Image),
      );

      expect(imageFinder, findsOneWidget);

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
