import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/models/category.dart';
import 'package:van_quang_tinh/src/models/crypto.dart';
import 'package:van_quang_tinh/src/models/data.dart';
import 'package:van_quang_tinh/src/screens/search_screen.dart';
import 'package:mocktail/mocktail.dart';
import '../../mock_data/category_mock_data.dart';
import '../../src/common/common_mock.dart';

void main() {
  final mockResponse = json.decode(mockCategorysData);
  var widget = MaterialApp(
    home: SearchScreen(
      dataCrypto: dataCrypto,
    ),
  );

  testWidgets('Display Appbar', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    final appbarFinder = find.byType(AppBar);
    expect(appbarFinder, findsOneWidget);
  });
  testWidgets('Display correctly Appbar\'s height',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    expect(
        (tester.firstWidget(find.byType(AppBar)) as AppBar).toolbarHeight, 60);
  });

  testWidgets('Display correctly Appbar\'s backgroundColor',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    expect((tester.firstWidget(find.byType(AppBar)) as AppBar).backgroundColor,
        Colors.white);
  });

  testWidgets('Display 2 Container', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    final appbarFinder = find.byType(Container);
    expect(appbarFinder, findsNWidgets(2));
  });

  testWidgets('Display correctly Container\'s color',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    expect(
      (tester.firstWidget(find.byType(Container)) as Container).decoration,
      const BoxDecoration(
        color: Colors.white,
      ),
    );
  });

  testWidgets('Display correctly TextField\'s hintText',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    final imageFinder = ((tester.widget(find.byType(TextField)) as TextField)
            .decoration as InputDecoration)
        .hintText;
    expect(imageFinder, 'Enter coins');
  });

  testWidgets('Display correctly TextField\'s border',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    final imageFinder = ((tester.widget(find.byType(TextField)) as TextField)
            .decoration as InputDecoration)
        .border;
    expect(imageFinder, const OutlineInputBorder());
  });

  testWidgets('Display correctly TextField\'s prefixIcon',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    final imageFinder = (((tester.widget(find.byType(TextField)) as TextField)
                .decoration as InputDecoration)
            .prefixIcon as Icon)
        .icon;
    expect(imageFinder, Icons.search);
  });

  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUpAll(() {
    registerFallbackValue(MyTypeFake());
  });
  testWidgets('Navigator push to SearchScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const SearchScreen(),
      navigatorObservers: [mockObserver],
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });

  testWidgets('Should render Category\'s data in TextField', (tester) async {
    List<Category>.from(mockResponse.map((model) => Category.fromJson(model)));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final albumCardFinder = find.byType(TextField);

    expect(albumCardFinder, findsOneWidget);
  });

   testWidgets('Display AutoComplete widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SearchScreen(),
    ));
    await tester.pumpAndSettle();
    final appbarFinder = find
        .byType(Autocomplete<Crypto>(optionsBuilder: (_) => []).runtimeType);
    expect(appbarFinder, findsOneWidget);
  });
}
