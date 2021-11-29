import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:van_quang_tinh/src/config/routes.dart';
import 'package:van_quang_tinh/src/screens/crypto_currency_screen.dart';
import 'package:van_quang_tinh/src/screens/crypto_detail_screen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyTypeFake extends Fake implements Route {}

class MockCryptoDetailBloc
    extends MockBloc<CryptoDetailEvent, CryptoDetailState>
    implements CryptoDetailBloc {}

class FakeCryptoDetailState extends Fake implements CryptoDetailState {}

class FakeCryptoDetailEvent extends Fake implements CryptoDetailEvent {}

class RouteFake extends Fake implements Route {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeCryptoDetailState());
    registerFallbackValue(FakeCryptoDetailEvent());
    registerFallbackValue(RouteFake());
  });

  late CryptoDetailBloc cryptoDetailBloc;

  setUp(() {
    cryptoDetailBloc = MockCryptoDetailBloc();
  });

  tearDown(() {
    cryptoDetailBloc.close();
  });
  var widget = MultiBlocProvider(
      providers: [BlocProvider(create: (context) => cryptoDetailBloc)],
      child: MaterialApp(
          routes: buildRoutes(), home: const CryptoCurrencyScreen()));
  double columnSpacing = 18;
  double horizontalMargin = 2;
  double dataRowHeight = 50;
  double headingRowHeight = 50;

  testWidgets('CryptoCurrencyScreen have SingleChildScrollView to scrollable',
      (tester) async {
    await tester.pumpWidget(widget);

    final scrollableFinder = find.byType(SingleChildScrollView);

    expect(scrollableFinder, findsOneWidget);
  });

  testWidgets('DataTable have 5 columns', (tester) async {
    await tester.pumpWidget(widget);

    final columnsFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .columns
            .length;

    expect(columnsFinder, 5);
  });

  testWidgets('Display correctly DataTable\'s column spacing', (tester) async {
    await tester.pumpWidget(widget);

    final columnSpacingFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable).columnSpacing;

    expect(columnSpacingFinder, columnSpacing);
  });

  testWidgets('Display correctly DataTable\'s horizontal margin',
      (tester) async {
    await tester.pumpWidget(widget);

    final horizontalMarginFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .horizontalMargin;

    expect(horizontalMarginFinder, horizontalMargin);
  });

  testWidgets('Display correctly DataTable\'s data row height', (tester) async {
    await tester.pumpWidget(widget);

    final dataRowHeightFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable).dataRowHeight;

    expect(dataRowHeightFinder, dataRowHeight);
  });

  testWidgets('Display correctly DataTable\'s heading row height',
      (tester) async {
    await tester.pumpWidget(widget);

    final headingRowHeightFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable)
            .headingRowHeight;

    expect(headingRowHeightFinder, headingRowHeight);
  });

  testWidgets('DataTable have the same number of rows as the number of data',
      (tester) async {
    await tester.pumpWidget(widget);

    final rowsFinder =
        (tester.firstWidget(find.byType(DataTable)) as DataTable).rows.length;

    expect(rowsFinder, 4);
  });

  testWidgets('Data Table should be tappable ', (tester) async {
    when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final dataTableFinder = find.byType(DataTable);

    expect(dataTableFinder, findsOneWidget);

    await tester.tap(dataTableFinder);

    await tester.pumpAndSettle();

    expect(find.byType(CryptoDetailScreen), findsOneWidget);
  });
}
