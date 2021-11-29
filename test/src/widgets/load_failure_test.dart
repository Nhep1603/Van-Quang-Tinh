import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:van_quang_tinh/src/constants/constants.dart' as app_constant;

void main() {
  testWidgets('TextButton should be tappable.', (WidgetTester tester) async {
    bool isTapped = false;
    await tester.pumpWidget(
      MaterialApp(
          home: TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: app_constant.LoadFailure.textButtonFontSize),
                  primary: Colors.green),
              onPressed: (){
                isTapped = true;
              },
              child:
                  const Text(app_constant.LoadFailure.loadFailureTryAgainText))),
    );
    final textButtonFinder = find.byType(TextButton);
    await tester.tap(textButtonFinder);
    expect(isTapped, true);
  });
}
