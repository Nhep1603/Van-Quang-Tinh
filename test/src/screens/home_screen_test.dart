import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:van_quang_tinh/src/screens/home_screen.dart';
import 'package:van_quang_tinh/src/constants/constants.dart' as app_constant;


void main() {
  testWidgets('Display Appbar', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    final appbarFinder = find.byType(AppBar);
    expect(appbarFinder, findsOneWidget);
  }
  );

  testWidgets('Display correctly Appbar\'s height', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    expect((tester.firstWidget(find.byType(AppBar)) as AppBar).toolbarHeight, 66.0);
  }
  );

  testWidgets('Display correctly Appbar\'s backgroundColor', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    expect((tester.firstWidget(find.byType(AppBar)) as AppBar).backgroundColor, Colors.white);
  }
  );

  testWidgets('Display Image', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  }
  );

  testWidgets('Display correctly Image\'s link', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    final imageFinder = ((tester.widget(find.byType(Image)) as Image).image as AssetImage).assetName;
    expect(imageFinder, app_constant.HomeScreen.logoLink);
  }
  );

  testWidgets('Display search button', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    final iconFinder = find.byType(IconButton);
    expect(iconFinder, findsOneWidget);
    final searchbuttonFinder = ((tester.widget(find.byType(IconButton)) as IconButton).icon as Icon).icon;
    expect(searchbuttonFinder, Icons.search);
  }
  );

  testWidgets('Display correctly search button\'s size', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    expect((tester.firstWidget(find.byType(IconButton)) as IconButton).iconSize, 24);
  }
  );

  testWidgets('Display correctly search button\'s color', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    expect((tester.firstWidget(find.byType(IconButton)) as IconButton).color, const Color(app_constant.HomeScreen.searchButtonColor));
  }
  );

  testWidgets('IconButton should be tappable.', (WidgetTester tester) async {
    bool isTapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        actions: <Widget>[
            IconButton(
            alignment: const Alignment(-3, 0),
            iconSize: 24,
            color: const Color(app_constant.HomeScreen.searchButtonColor),
            icon: const Icon(Icons.search),
            onPressed: () {
              isTapped = true;
            },
          ),
        ]
      ),
        ),
      ),
    );
    final iconButtonFinder = find.byType(IconButton);
    await tester.tap(iconButtonFinder);
    expect(isTapped, true);
  });

  
}