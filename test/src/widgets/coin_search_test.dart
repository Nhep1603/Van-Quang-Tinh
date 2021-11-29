import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:van_quang_tinh/src/blocs/search/search_bloc.dart';
import 'package:van_quang_tinh/src/blocs/search/search_state.dart';
import 'package:van_quang_tinh/src/config/routes.dart';
import 'package:van_quang_tinh/src/models/crypto.dart';
import 'package:van_quang_tinh/src/screens/search_screen.dart';
import 'package:van_quang_tinh/src/services/crypto_currency/crypto_currency_service.dart';
import 'package:van_quang_tinh/src/widgets/coin_search.dart';
import 'package:van_quang_tinh/src/widgets/load_failure.dart';
import '../../mock_data/crypto_mock_data.dart';
import '../../src/common/common_mock.dart';

main() {
  final mockResponse = json.decode(mockCryptoData);
  final mockObserver = MockNavigatorObserver();
  
  setUpAll(() {
    registerFallbackValue(FakeSearchState());
    registerFallbackValue(FakeSearchEvent());
    registerFallbackValue(FakeCryptoDetailState());
    registerFallbackValue(FakeCryptoDetailEvent());
    registerFallbackValue(RouteFake());
  });

    late CryptoCurrencyService cryptoService;
    late SearchBloc searchBloc;
    late CryptoDetailBloc cryptoDetailBloc;
    var widget = MultiBlocProvider(providers: [
      BlocProvider(create: (context) => searchBloc),
      BlocProvider(create: (context) => cryptoDetailBloc)
    ], child: const MaterialApp(onGenerateRoute: Routes.onGenerateRoute,
    home: SearchScreen()));

    setUp(() {
      cryptoService = MockSearchService();
      searchBloc = MockSearchBloc();
      cryptoDetailBloc = MockCryptoDetailBloc();
    });

    tearDown(() {
      searchBloc.close();
      cryptoDetailBloc.close();
    });

    testWidgets(
        'Should render 2 Container when bloc state is [SearchLoadSucess]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadSuccess(
          cryptos: List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model)))));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsNWidgets(2));
    });

    testWidgets(
        'Should render correctly Container\'s color when bloc state is [SearchLoadSucess]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadSuccess(
          cryptos: List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model)))));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(
        (tester.firstWidget(find.byType(Container)) as Container).decoration,
        const BoxDecoration(
          color: Colors.white,
        ),
      );
    });

    testWidgets(
        'Display correctly TextField\'s hintText when bloc state is [SearchLoadSucess]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadSuccess(
          cryptos: List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model)))));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final textFieldFinder =
          ((tester.widget(find.byType(TextField)) as TextField).decoration
                  as InputDecoration)
              .hintText;
      expect(textFieldFinder, 'Enter coins');
    });

    testWidgets(
        'Display correctly TextField\'s border when bloc state is [SearchLoadSucess]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadSuccess(
          cryptos: List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model)))));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final textFieldFinder =
          ((tester.widget(find.byType(TextField)) as TextField).decoration
                  as InputDecoration)
              .border;
      expect(textFieldFinder, const OutlineInputBorder());
    });

    testWidgets(
        'Display correctly TextField\'s prefixIcon when bloc state is [SearchLoadSucess]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadSuccess(
          cryptos: List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model)))));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final textFieldFinder =
          (((tester.widget(find.byType(TextField)) as TextField).decoration
                      as InputDecoration)
                  .prefixIcon as Icon)
              .icon;
      expect(textFieldFinder, Icons.search);
    });

        testWidgets(
        'Should render Category\'s data in TextField when bloc state is [SearchLoadSucess]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadSuccess(
          cryptos: List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model)))));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);
    });

    testWidgets(
        'Display AutoComplete widget when bloc state is [SearchLoadSucess]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadSuccess(
          cryptos: List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model)))));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final autocompleteFinder = find
          .byType(Autocomplete<Crypto>(optionsBuilder: (_) => []).runtimeType);
      expect(autocompleteFinder, findsOneWidget);
    });

    testWidgets(
        'Should render LoadFailure widget when search bloc state is [SearchLoadFailure]',
        (tester) async {
      when(() => searchBloc.state)
          .thenReturn(SearchLoadFailure());
      await tester.pumpWidget(widget);
      await tester.pump();
      final errorMessageFinder = find.byType(LoadFailure);
      expect(errorMessageFinder, findsOneWidget);
    });

    testWidgets(
        'Should render orange container with error message when not have any bloc state',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchInitial());
      await tester.pumpWidget(widget);
      await tester.pump();
      expect((tester.widget(find.byType(Container)) as Container).color,
          Colors.orange);
    });

    testWidgets(
        'Should render Search bar when bloc state is [SearchLoadSuccess]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadSuccess(
        cryptos: List<Crypto>.from(
            mockResponse.map((model) => Crypto.fromJson(model))).toList(),
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(find.byType(SearchScreen), findsOneWidget);
    });

    testWidgets('Should search Coin when bloc state is [SearchLoadSuccess]',
        (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
      when(() => searchBloc.state).thenReturn(SearchLoadSuccess(
        cryptos: List<Crypto>.from(
            mockResponse.map((model) => Crypto.fromJson(model))).toList(),
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CoinSearch));
      await tester.enterText(find.byType(CoinSearch), 'bit');
      await tester.pump(const Duration(seconds: 1));
      final coinCardFinder = find.descendant(
          of: find.byType(ListView), matching: find.byType(Card).first);
      expect(coinCardFinder, findsOneWidget);
      await tester.tap(coinCardFinder);
      await tester.pumpAndSettle();
      verifyNever(() => mockObserver.didPush(any(), any()));
    });

    testWidgets('Should reload when tap on TextButton when bloc state is [SearchLoadFailure]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadFailure());
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
    
}