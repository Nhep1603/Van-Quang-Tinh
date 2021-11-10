import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/widgets/text_with_border.dart';

void main() {
  var widget = const MaterialApp(
    home: Scaffold(
      body: TextWithBorder(
        text: 'text with border',
        textColor: Colors.red,
        boxColor: Colors.green,
      ),
    ),
  );

  testWidgets('Should render a text', (tester) async {
    await tester.pumpWidget(widget);

    final textFinder = find.text('text with border');

    expect(textFinder, findsOneWidget);
  });
}
