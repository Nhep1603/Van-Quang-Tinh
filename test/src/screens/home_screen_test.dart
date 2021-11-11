import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/app.dart';

void main() {
  const colorOfTextAndIndicator = Color(0xff8FC746);
  const labelStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 18);
  final _tabs = ['Cryptocurrency', 'Categories'];

  var widget = const MaterialApp(
    home: App(),
  );

  group('Tab bar Widget Testing', () {
    testWidgets('Should render Tab bar with correct screen name number',
        (tester) async {
      await tester.pumpWidget(widget);

      final screenNameNumberFinder =
          ((tester.widget(find.byType(TabBar)) as TabBar).tabs).length;

      expect(screenNameNumberFinder, 2);
    });

    testWidgets('Should render Tab bar with correct initialIndex',
        (tester) async {
      await tester.pumpWidget(widget);

      final initialIndexFinder =
          ((tester.widget(find.byType(DefaultTabController))
                  as DefaultTabController)
              .initialIndex);

      expect(initialIndexFinder, 0);
    });

    testWidgets('Should render Tab bar with correct first screen name',
        (tester) async {
      await tester.pumpWidget(widget);

      final firstScreenNameFinder =
          (((tester.widget(find.byType(TabBar)) as TabBar).tabs).elementAt(0)
                  as Tab)
              .text;

      expect(firstScreenNameFinder, _tabs[0]);
    });

    testWidgets('Should render Tab bar with first screen name one time',
        (tester) async {
      await tester.pumpWidget(widget);

      expect(find.text(_tabs[0]), findsOneWidget);
    });

    testWidgets('Should render Tab bar with correct second screen name',
        (tester) async {
      await tester.pumpWidget(widget);

      final secondScreenNameFinder =
          (((tester.widget(find.byType(TabBar)) as TabBar).tabs).elementAt(1)
                  as Tab)
              .text;

      expect(secondScreenNameFinder, _tabs[1]);
    });

    testWidgets('Should render Tab bar with second screen name one time',
        (tester) async {
      await tester.pumpWidget(widget);

      expect(find.text(_tabs[1]), findsOneWidget);
    });

    testWidgets('Should render Tab bar with correct label color',
        (tester) async {
      await tester.pumpWidget(widget);

      final labelColorFinder =
          ((tester.widget(find.byType(TabBar)) as TabBar).labelColor);

      expect(labelColorFinder, colorOfTextAndIndicator);
    });

    testWidgets('Should render Tab bar with correct indicator color',
        (tester) async {
      await tester.pumpWidget(widget);

      final indicatorColorFinder =
          ((tester.widget(find.byType(TabBar)) as TabBar).indicatorColor);

      expect(indicatorColorFinder, colorOfTextAndIndicator);
    });

    testWidgets('Should render Tab bar with correct indicator weight',
        (tester) async {
      await tester.pumpWidget(widget);

      final indicatorWeightFinder =
          ((tester.widget(find.byType(TabBar)) as TabBar).indicatorWeight);

      expect(indicatorWeightFinder, 2);
    });

    testWidgets('Should render Tab bar with correct unselected label color',
        (tester) async {
      await tester.pumpWidget(widget);

      final unselectedLabelColorFinder =
          ((tester.widget(find.byType(TabBar)) as TabBar).unselectedLabelColor);

      expect(unselectedLabelColorFinder, Colors.black);
    });

    testWidgets('Should render Tab bar with correct label style',
        (tester) async {
      await tester.pumpWidget(widget);

      final labelStyleFinder =
          ((tester.widget(find.byType(TabBar)) as TabBar).labelStyle);

      expect(labelStyleFinder, labelStyle);
    });

    testWidgets('Should render Tab bar with correct tabbar view',
        (tester) async {
      await tester.pumpWidget(widget);

      final tabbarviewFinder =
          (tester.widget(find.byType(TabBarView)) as TabBarView)
              .children
              .length;

      expect(tabbarviewFinder, 2);
    });
  });
}
