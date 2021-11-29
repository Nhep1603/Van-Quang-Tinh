import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:van_quang_tinh/src/app.dart';
import 'package:van_quang_tinh/src/blocs/search/search_bloc.dart';
import 'package:van_quang_tinh/src/config/routes.dart';
import 'package:van_quang_tinh/src/screens/home_screen.dart';
import 'package:van_quang_tinh/src/constants/constants.dart' as app_constant;
import 'package:mocktail/mocktail.dart';
import '../../src/common/common_mock.dart';

void main() {
  const colorOfTextAndIndicator = Color(0xff8FC746);
  const labelStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
  final _tabs = ['Cryptocurrency', 'Categories'];

  var widget = const MaterialApp(
    onGenerateRoute: Routes.onGenerateRoute,
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

 group('App bar Widget Testing', () {
  testWidgets('Display Appbar', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    final appbarFinder = find.byType(AppBar);
    expect(appbarFinder, findsOneWidget);
  }
  );

  testWidgets('Display correctly Appbar\'s height', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    expect((tester.firstWidget(find.byType(AppBar)) as AppBar).toolbarHeight, 51.00000000000001);
  }
  );

  testWidgets('Display correctly Appbar\'s backgroundColor', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    expect((tester.firstWidget(find.byType(AppBar)) as AppBar).backgroundColor, Colors.white);
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
    expect((tester.firstWidget(find.byType(IconButton)) as IconButton).iconSize, 21.000000000000004);
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

  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUpAll(() {
    registerFallbackValue(MyTypeFake());
  });
  testWidgets('Navigator push to SearchScreen', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => SearchBloc(),
        child: MaterialApp(
          onGenerateRoute: Routes.onGenerateRoute,
          home: const HomeScreen(),
          navigatorObservers: [mockObserver],
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      verify(() => mockObserver.didPush(any(), any()));
    });

});

}
  

