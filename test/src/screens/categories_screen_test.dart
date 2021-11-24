import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:van_quang_tinh/src/blocs/category/category_bloc.dart';
import 'package:van_quang_tinh/src/blocs/category/category_state.dart';
import 'package:van_quang_tinh/src/config/routes.dart';
import 'package:van_quang_tinh/src/models/category.dart';
import 'package:van_quang_tinh/src/screens/categories_screen.dart';
import 'package:van_quang_tinh/src/services/category/category_service.dart';
import 'package:van_quang_tinh/src/widgets/load_failure.dart';
import '../../mock_data/category_mock_data.dart';
import '../../src/common/common_mock.dart';

main() {
  final mockResponse = json.decode(mockCategoriesData);
  final mockObserver = MockNavigatorObserver();

  setUpAll(() {
    registerFallbackValue(FakeCategoryState());
    registerFallbackValue(FakeCategoryEvent());
    registerFallbackValue(RouteFake());
  });

  late CategoryService categoryService;
  late CategoryBloc categoryBloc;
  var widget = MaterialApp(
    routes: buildRoutes(),
    home: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => categoryBloc)],
        child: const CategoriesScreen()),
  );

  setUp(() {
    categoryService = MockCategoryService();
    categoryBloc = MockCategoryBloc();
  });

  tearDown(() {
    categoryBloc.close();
  });

  testWidgets(
      'Should render a SingleChildScrollView when bloc state is [CryptoLoadSucess]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadSucess(
        categories: List<Category>.from(
            mockResponse.map((model) => Category.fromJson(model)))));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    final singleChildScrollViewFinder = find.byType(SingleChildScrollView);
    expect(singleChildScrollViewFinder, findsOneWidget);
  });

  testWidgets('Should render a DataTable when bloc state is [CryptoLoadSucess]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadSucess(
        categories: List<Category>.from(
            mockResponse.map((model) => Category.fromJson(model)))));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    final datatableFinder = find.byType(DataTable);
    expect(datatableFinder, findsOneWidget);
  });

  testWidgets(
      'Display correctly DataTable\'s column spacing when bloc state is [CryptoLoadSucess]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadSucess(
        categories: List<Category>.from(
            mockResponse.map((model) => Category.fromJson(model)))));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable).columnSpacing,
        18.0);
  });

  testWidgets(
      'Display correctly DataTable\'s horizontal margin when bloc state is [CryptoLoadSucess]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadSucess(
        categories: List<Category>.from(
            mockResponse.map((model) => Category.fromJson(model)))));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .horizontalMargin,
        10.0);
  });

  testWidgets(
      'Display correctly DataTable\'s data row height when bloc state is [CryptoLoadSucess]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadSucess(
        categories: List<Category>.from(
            mockResponse.map((model) => Category.fromJson(model)))));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable).dataRowHeight,
        53.5);
  });

  testWidgets(
      'Display correctly DataTable\'s heading row height when bloc state is [CryptoLoadSucess]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadSucess(
        categories: List<Category>.from(
            mockResponse.map((model) => Category.fromJson(model)))));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .headingRowHeight,
        50.0);
  });

  testWidgets('DataTable have 4 columns when bloc state is [CryptoLoadSucess]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadSucess(
        categories: List<Category>.from(
            mockResponse.map((model) => Category.fromJson(model)))));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .columns
            .length,
        4);
  });

  testWidgets(
      'Should render LoadFailure widget when crypto bloc state is [CryptoLoadFailure]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadFailure());
    await tester.pumpWidget(widget);
    await tester.pump();
    final loadFailureFinder = find.byType(LoadFailure);
    expect(loadFailureFinder, findsOneWidget);
  });

  testWidgets(
      'Should render green container with error message when not have any bloc state',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryInitial());
    await tester.pumpWidget(widget);
    await tester.pump();
    expect((tester.widget(find.byType(Container)) as Container).color,
        Colors.green);
  });

  testWidgets(
      'Should have RefreshIndicator when bloc state is [CryptoLoadSucess]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadSucess(
        categories: List<Category>.from(
            mockResponse.map((model) => Category.fromJson(model)))));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    final datatableFinder = find.byType(RefreshIndicator);
    expect(datatableFinder, findsOneWidget);
  });

  testWidgets(
      'Should reload when tap on TextButton when bloc state is [CategoryLoadFailure]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadFailure());
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(LoadFailure));
    await tester.pump(const Duration(seconds: 1));
    final coinCardFinder = find.descendant(
        of: find.byType(Container), matching: find.byType(TextButton));
    expect(coinCardFinder, findsOneWidget);
    await tester.tap(coinCardFinder);
    await tester.pumpAndSettle();
    verifyNever(() => mockObserver.didPush(any(), any()));
  });

  testWidgets(
      'Should refresh when drag when bloc state is [CategoryLoadFailure]',
      (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryLoadSucess(
        categories: List<Category>.from(
            mockResponse.map((model) => Category.fromJson(model)))));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.drag(find.text('Category'), const Offset(0.0, 100.0));
    await tester.pumpAndSettle();
    verifyNever(() => mockObserver.didPush(any(), any()));
  });

}
