import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:van_quang_tinh/src/widgets/custom_app_bar.dart';

void main() {
  var widget = const MaterialApp(
    home: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomAppBar(
          icondata: Icons.arrow_back,
          symbolImagePath: 'assets/images/bitcoin_symbol.png',
          titleAppBar: 'Bitcoin',
        ),
      ),
    ),
  );

  testWidgets('Should render CustomAppBar with title', (tester) async {
    await tester.pumpWidget(widget);

    final titleFinder = find.descendant(
      of: find.byType(CustomAppBar),
      matching: find.text('Bitcoin'),
    );

    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Should render CustomAppBar with a image.',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    final image = Image.asset('assets/images/bitcoin_symbol.png');
    final assetImage = image.image as AssetImage;

    expect(assetImage.assetName, 'assets/images/bitcoin_symbol.png');
  });

  testWidgets('Should render CustomAppBar with a arrow_back button.',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    final iconFinder = find.byIcon(Icons.arrow_back);

    expect(iconFinder, findsOneWidget);
  });

  testWidgets('CustomAppBar should be tappable.', (WidgetTester tester) async {
    bool isTapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: CustomAppBar(
              icondata: Icons.arrow_back,
              symbolImagePath: 'assets/images/bitcoin_symbol.png',
              titleAppBar: 'Bitcoin',
              onPressed: () {
                isTapped = true;
              },
            ),
          ),
        ),
      ),
    );

    final iconButtonFinder = find.byType(IconButton);
    await tester.tap(iconButtonFinder);

    expect(isTapped, true);
  });
}
