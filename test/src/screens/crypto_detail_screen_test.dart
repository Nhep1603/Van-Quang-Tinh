import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/screens/crypto_detail_screen.dart';

void main() {
  group('Crypto detail screen testing', () {
    testWidgets('Should display data text.',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CryptoDetailScreen()));
      final data = find.text('data');
      expect(data, findsOneWidget);
    });
  });
}