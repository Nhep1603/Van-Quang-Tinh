import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_currency/crypto_currency_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_currency/crypto_currency_state.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:van_quang_tinh/src/config/routes.dart';
import 'package:van_quang_tinh/src/models/crypto.dart';
import 'package:van_quang_tinh/src/screens/crypto_currency_screen.dart';
import 'package:van_quang_tinh/src/screens/crypto_detail_screen.dart';
import 'package:van_quang_tinh/src/services/crypto_currency/crypto_currency_service.dart';
import '../../mock_data/crypto_currency_data.dart';
import '../common/common_mock.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

class MockCryptoDetailBloc
    extends MockBloc<CryptoDetailEvent, CryptoDetailState>
    implements CryptoDetailBloc {}

class FakeCryptoDetailState extends Fake implements CryptoDetailState {}

class FakeCryptoDetailEvent extends Fake implements CryptoDetailEvent {}

class RouteFake extends Fake implements Route {}

void main() {

  CustomBindings();
  final mockResponse = json.decode(mockCryptoCurrencyData);

  setUpAll(() {
    registerFallbackValue(FakeCryptoCurrencyState());
    registerFallbackValue(FakeCryptoCurrencyEvent());
    registerFallbackValue(FakeCryptoDetailState());
    registerFallbackValue(FakeCryptoDetailEvent());
    registerFallbackValue(RouteFake());
  });

  late CryptoCurrencyService cryptoCurrencyService;
  late CryptoCurrencyBloc cryptoCurrencyBloc;
  late CryptoDetailBloc cryptoDetailBloc;

  setUp(() {
    cryptoCurrencyService = MockCryptoCurrencyService();
    cryptoCurrencyBloc = MockCryptoCurrencyBloc();
    cryptoDetailBloc = MockCryptoDetailBloc();
  });

  tearDown(() {
    cryptoCurrencyBloc.close();
    cryptoDetailBloc.close();
  });

  var widget = MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => cryptoCurrencyBloc,
      ),
      BlocProvider(
        create: (context) => cryptoDetailBloc,
      ),
    ],
    child: const MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
      home: CryptoCurrencyScreen(),
    ),
  );

  double columnSpacing = 4;
  double horizontalMargin = 5;
  double dataRowHeight = 55;
  double headingRowHeight = 50;
  String errorMessage = 'errorMessage';
  final _cryptos =
      List<Crypto>.from(mockResponse.map((model) => Crypto.fromJson(model)));

  testWidgets(
      'Should render orange container when crypto bloc state is [CryptoCurrencyInitial]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(CryptoCurrencyInitial());
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final orangeContainerFinder =
        (tester.widget(find.byType(Container)) as Container).color;

    expect(orangeContainerFinder, Colors.orange);
  });

  testWidgets(
      'Should render red container with error message when crypto bloc state is [CryptoCurrencyFailure]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state)
        .thenReturn(CryptoCurrencyLoadFailure(errorMessage: errorMessage));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final errorMessageFinder = find.text(errorMessage);
    expect(errorMessageFinder, findsOneWidget);
    expect(
        (tester.widget(find.byType(Container)) as Container).color, Colors.red);
  });

  testWidgets(
      'Should render a SingleChildScrollView when bloc state is [CryptoCurrencyLoadSucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final singleChildScrollViewFinder = find.byType(SingleChildScrollView);

    expect(singleChildScrollViewFinder, findsOneWidget);
  });

  testWidgets(
      'Should render a RefreshIndicator when bloc state is [CryptoCurrencyLoadSucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final refreshIndicatorFinder = find.byType(RefreshIndicator);

    expect(refreshIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should render Data Table when bloc state is [CryptoCurrencyLoadSucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));

    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final dataTabledFinder = find.byType(DataTable);

    expect(dataTabledFinder, findsOneWidget);
  });

  testWidgets(
      'Should render Data Table have 5 columns when bloc state is [CryptoCurrencyLoadSucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final columnsFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .columns
            .length;

    expect(columnsFinder, 5);
  });

  testWidgets(
      'Display correctly DataTable\'s column spacing when bloc state is [CryptoCurrencyLoadSucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final columnSpacingFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable).columnSpacing;

    expect(columnSpacingFinder, columnSpacing);
  });

  testWidgets(
      'Display correctly DataTable\'s horizontal margin when bloc state is [CryptoCurrencyLoadSucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final horizontalMarginFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .horizontalMargin;

    expect(horizontalMarginFinder, horizontalMargin);
  });

  testWidgets(
      'Display correctly DataTable\'s data row height when bloc state is [CryptoCurrencyLoadSucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final dataRowHeightFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable).dataRowHeight;

    expect(dataRowHeightFinder, dataRowHeight);
  });

  testWidgets(
      'Display correctly DataTable\'s heading row height when bloc state is [CryptoCurrencySucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final headingRowHeightFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .headingRowHeight;

    expect(headingRowHeightFinder, headingRowHeight);
  });

  testWidgets(
      'DataTable have the same number of rows as the number of data when bloc state is [CryptoCurrencyLoadSucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final headingRowHeightFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable).rows.length;

    expect(
        headingRowHeightFinder,
        List<Crypto>.from(mockResponse.map((model) => Crypto.fromJson(model)))
            .length);
  });

  testWidgets(
      'Data Table should be tappable when bloc state is [CryptoCurrencyLoadSucess]',
      (tester) async {
    when(() => cryptoCurrencyBloc.state).thenReturn(
        CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: true));
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);

    final iconButtonFinder = find.byType(DataTable);

    expect(iconButtonFinder, findsOneWidget);

    await tester.tap(iconButtonFinder);

    await tester.pumpAndSettle();

    expect(find.byType(CryptoDetailScreen), findsOneWidget);
  });
}
