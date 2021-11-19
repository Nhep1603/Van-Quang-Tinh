import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:van_quang_tinh/src/enum/line_chart_enum.dart';
import 'package:van_quang_tinh/src/screens/crypto_detail_screen.dart';
import 'package:van_quang_tinh/src/constants/constants.dart' as constants;
import 'package:van_quang_tinh/src/widgets/custom_crypto_price_line_chart.dart';

class MockCryptoDetailBloc
    extends MockBloc<CryptoDetailEvent, CryptoDetailState>
    implements CryptoDetailBloc {}

class FakeCryptoDetailState extends Fake implements CryptoDetailState {}

class FakeCryptoDetailEvent extends Fake implements CryptoDetailEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeCryptoDetailState());
    registerFallbackValue(FakeCryptoDetailEvent());
  });

  group('Crypto Detail Screen Tests', () {
    late CryptoDetailBloc cryptoDetailBloc;
    var widget = MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cryptoDetailBloc,
        )
      ],
      child: const MaterialApp(
        home: CryptoDetailScreen(),
      ),
    );
    setUp(() {
      cryptoDetailBloc = MockCryptoDetailBloc();
    });

    tearDown(() {
      cryptoDetailBloc.close();
    });

    testWidgets('Should render Appbar with PreferredSize widget.',
        (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final preferredSizeWidgetFinder = find.byType(PreferredSize);

      expect(preferredSizeWidgetFinder, findsOneWidget);
    });

    testWidgets('Appbar should not be tappable.', (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final iconButtonFinder = find.byType(IconButton);
      expect(iconButtonFinder, findsOneWidget);

      await tester.tap(iconButtonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(CryptoDetailScreen), findsOneWidget);
    });

    testWidgets('Should display one line chart.', (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final iconButtonFinder = find.byType(CustomCryptoPriceLineChart);
      expect(iconButtonFinder, findsOneWidget);
    });

    testWidgets(
        'Should display one line chart for last 24 hours when crypto detail bloc state is CryptoDetailLoadSucess with [lineChartType: LineChartType.chart24H].',
        (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSucess(
        isVoted: false,
        lineChartType: LineChartType.chart24H,
      ));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final customCryptoPriceLineChartFinder =
          tester.widget<CustomCryptoPriceLineChart>(
        find.byType(CustomCryptoPriceLineChart),
      );

      expect(customCryptoPriceLineChartFinder.lineChartType,
          LineChartType.chart24H);
    });

    testWidgets(
        'Should display one line chart for last 7 days when crypto detail bloc state is CryptoDetailLoadSucess with [lineChartType: LineChartType.chart7D].',
        (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSucess(
        isVoted: false,
        lineChartType: LineChartType.chart7D,
      ));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final customCryptoPriceLineChartFinder =
          tester.widget<CustomCryptoPriceLineChart>(
        find.byType(CustomCryptoPriceLineChart),
      );

      expect(customCryptoPriceLineChartFinder.lineChartType,
          LineChartType.chart7D);
    });

    testWidgets(
        'Should display [thanksForYourVote] when crypto detail bloc state is CryptoDetailLoadSucess with [isVoted: true].',
        (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSucess(
        isVoted: true,
        lineChartType: LineChartType.chart24H,
      ));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final thanksForYourVoteFinder =
          find.text(constants.CryptoDetailScreen.thanksForYourVote);
      expect(thanksForYourVoteFinder, findsOneWidget);
    });

    testWidgets(
        'Should call CryptoDetailLoadedChart event when [button7days] is tapped.',
        (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn((CryptoDetailLoadSucess(
        isVoted: true,
        lineChartType: LineChartType.chart24H,
      )));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final textButtonFinder = find.ancestor(
        of: find.text(constants.CryptoDetailScreen.button7Days),
        matching: find.byType(TextButton),
      );

      expect(textButtonFinder, findsOneWidget);

      await tester.tap(textButtonFinder);
      await tester.pumpAndSettle();

      verify(() => cryptoDetailBloc.add(const CryptoDetailLoadedChart(
          lineChartType: LineChartType.chart7D))).called(1);
    });

    testWidgets(
        'Should call CryptoDetailLoadedChart event when [button24hours] is tapped.',
        (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn((CryptoDetailLoadSucess(
        isVoted: true,
        lineChartType: LineChartType.chart24H,
      )));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final textButtonFinder = find.ancestor(
        of: find.text(constants.CryptoDetailScreen.button24Hours),
        matching: find.byType(TextButton),
      );

      expect(textButtonFinder, findsOneWidget);

      await tester.tap(textButtonFinder);
      await tester.pumpAndSettle();

      verify(() => cryptoDetailBloc.add(const CryptoDetailLoadedChart(
          lineChartType: LineChartType.chart24H))).called(1);
    });

    testWidgets(
        'Should call CryptoDetailVoted event when [sadEmojiTextButton] is tapped.',
        (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final sadEmojiTextButtonFinder = find
          .ancestor(
            of: find.byType(Image),
            matching: find.byType(TextButton),
          )
          .first;
      await tester.ensureVisible(sadEmojiTextButtonFinder);

      await tester.tap(sadEmojiTextButtonFinder);
      await tester.pumpAndSettle();

      verify(() => cryptoDetailBloc.add(CryptoDetailVoted())).called(1);
    });

    testWidgets(
        'Should call CryptoDetailVoted event when [smileEmojiTextButton] is tapped.',
        (tester) async {
      when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final smileEmojiTextButtonFinder = find
          .ancestor(
            of: find.byType(Image),
            matching: find.byType(TextButton),
          )
          .last;
      await tester.ensureVisible(smileEmojiTextButtonFinder);

      await tester.tap(smileEmojiTextButtonFinder);
      await tester.pumpAndSettle();

      verify(() => cryptoDetailBloc.add(CryptoDetailVoted())).called(1);
    });
  });
}
