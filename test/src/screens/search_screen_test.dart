import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:van_quang_tinh/src/blocs/search/search_bloc.dart';
import 'package:van_quang_tinh/src/config/routes.dart';
import 'package:van_quang_tinh/src/screens/search_screen.dart';
import 'package:van_quang_tinh/src/screens/home_screen.dart';

void main() {
  var widget = BlocProvider(
    create: (context) => SearchBloc(),
    child: const MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
      home: SearchScreen(),
    ),
  );

  testWidgets('Display Appbar', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    final appbarFinder = find.byType(AppBar);
    expect(appbarFinder, findsOneWidget);
  });
  testWidgets('Display correctly Appbar\'s height',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    expect(
        (tester.firstWidget(find.byType(AppBar)) as AppBar).toolbarHeight, 60);
  });

  testWidgets('Display correctly Appbar\'s backgroundColor',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    expect((tester.firstWidget(find.byType(AppBar)) as AppBar).backgroundColor,
        Colors.white);
  });

  testWidgets('Display one Container', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    final containerFinder = find.byType(Container);
    expect(containerFinder, findsNWidgets(1));
  });

  testWidgets(
      'Navigator pop to HomeScreen',
      (tester) async {

    await tester.pumpWidget(widget);

    await tester.pumpAndSettle();

    final iconButtonFinder = find.byType(IconButton);

    expect(iconButtonFinder, findsOneWidget);

    await tester.tap(iconButtonFinder);

    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsNothing);
  });

}