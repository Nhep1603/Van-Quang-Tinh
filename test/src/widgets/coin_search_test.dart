import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/search/search_bloc.dart';
import 'package:van_quang_tinh/src/blocs/search/search_state.dart';
import 'package:van_quang_tinh/src/config/routes.dart';
import 'package:van_quang_tinh/src/models/crypto.dart';
import 'package:van_quang_tinh/src/screens/search_screen.dart';
import 'package:van_quang_tinh/src/services/crypto_currency/crypto_currency_service.dart';
import '../../mock_data/crypto_mock_data.dart';
import '../../common/common_mock.dart';

main() {
  final mockResponse = json.decode(mockCryptoData);
  
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
    ], child: MaterialApp(routes: buildRoutes(), home: const SearchScreen()));

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
        'Should render two Container when bloc state is [SearchLoadSucess]',
        (tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoadSucess(
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
      when(() => searchBloc.state).thenReturn(SearchLoadSucess(
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
      when(() => searchBloc.state).thenReturn(SearchLoadSucess(
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
      when(() => searchBloc.state).thenReturn(SearchLoadSucess(
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
      when(() => searchBloc.state).thenReturn(SearchLoadSucess(
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
}