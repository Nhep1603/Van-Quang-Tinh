import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail_function/crypto_detail_function_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail_function/crypto_detail_function_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail_function/crypto_detail_function_state.dart';
import 'package:van_quang_tinh/src/enum/line_chart_enum.dart';
import 'package:van_quang_tinh/src/models/crypto_detail.dart';
import 'package:van_quang_tinh/src/models/prices.dart';
import 'package:van_quang_tinh/src/screens/crypto_detail_screen.dart';
import 'package:van_quang_tinh/src/constants/constants.dart' as constants;
import 'package:van_quang_tinh/src/services/crypto_detail/crypto_detail_service.dart';
import 'package:van_quang_tinh/src/services/prices/prices_service.dart';
import 'package:van_quang_tinh/src/utils/custom_number_format.dart';
import 'package:van_quang_tinh/src/widgets/currency_conversion_text_field.dart';
import 'package:van_quang_tinh/src/widgets/custom_crypto_price_line_chart.dart';

import '../../mock_data/crypto_detail_data.dart';
import '../../mock_data/line_chart_data.dart';
import '../common/mock_network.dart';
import '../common/common_mock.dart';

void main() {
  final cryptoDetail = json.decode(rawBitcoin);
  final prices24h = json.decode(rawDatas24H);
  final prices7d = json.decode(rawData7D);

  setUpAll(() {
    registerFallbackValue(FakeCryptoDetailState());
    registerFallbackValue(FakeCryptoDetailEvent());
    registerFallbackValue(FakeCryptoDetailFunctionState());
    registerFallbackValue(FakeCryptoDetailFunctionEvent());
  });

  group('Crypto Detail Screen Tests', () {
    late CryptoDetailService cryptoDetailService;
    late PricesService pricesService;
    late CryptoDetailBloc cryptoDetailBloc;
    late CryptoDetailFunctionBloc cryptoDetailFunctionBloc;
    var widget = MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => cryptoDetailBloc),
        BlocProvider(create: (context) => cryptoDetailFunctionBloc),
      ],
      child: const MaterialApp(
        home: CryptoDetailScreen('bitcoin'),
      ),
    );

    setUp(() {
      cryptoDetailService = MockCryptoDetailService();
      pricesService = MockPricesService();
      cryptoDetailBloc = MockCryptoDetailBloc();
      cryptoDetailFunctionBloc = MockCryptoDetailFunctionBloc();
    });

    tearDown(() {
      cryptoDetailBloc.close();
      cryptoDetailFunctionBloc.close();
    });

    testWidgets(
        'Should render orange container when crypto detail bloc state is [CryptoDetailInitial]',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailInitial());
        await tester.pumpWidget(widget);
        await tester.pump();

        expect((tester.widget(find.byType(Container)) as Container).color,
            Colors.orange);
      });
    });

    testWidgets(
        'Should render progress indicator when crypto detail bloc state is [CryptoDetailLoadInProgress]',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailBloc.state)
            .thenReturn(CryptoDetailLoadInProgress());

        await tester.pumpWidget(widget);
        await tester.pump();

        final indicatorFinder = find.byType(CircularProgressIndicator);
        expect(indicatorFinder, findsOneWidget);
      });
    });

    testWidgets(
        'Should render red container with error message when crypto detail bloc state is [CryptoDetailLoadFailure]',
        (tester) async {
      await mockNetworkImages(() async {
        const errorMessage = 'errorMessage';
        when(() => cryptoDetailBloc.state)
            .thenReturn(CryptoDetailLoadFailure(errorMessage: errorMessage));

        await tester.pumpWidget(widget);
        await tester.pump();

        final errorMessageFinder = find.text(errorMessage);
        expect(errorMessageFinder, findsOneWidget);
        expect((tester.widget(find.byType(Container)) as Container).color,
            Colors.red);
      });
    });

    testWidgets('Should render Appbar with PreferredSize widget.',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final preferredSizeWidgetFinder = find.byType(PreferredSize);

        expect(preferredSizeWidgetFinder, findsOneWidget);
      });
    });

    testWidgets('Appbar should not be tappable.', (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final iconButtonFinder = find.byType(IconButton);
        expect(iconButtonFinder, findsOneWidget);

        await tester.tap(iconButtonFinder);
        await tester.pumpAndSettle();

        expect(find.byType(CryptoDetailScreen), findsOneWidget);
      });
    });

    testWidgets('Should display one line chart.', (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final iconButtonFinder = find.byType(CustomCryptoPriceLineChart);
        expect(iconButtonFinder, findsOneWidget);
      });
    });

    testWidgets(
        'Should display one line chart for last 24 hours when crypto detail bloc state is CryptoDetailLoadSucess with [lineChartType: LineChartType.chart24H].',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
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
    });

    testWidgets(
        'Should display one line chart for last 7 days when crypto detail bloc state is CryptoDetailLoadSucess with [lineChartType: LineChartType.chart7D].',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));
        when(() => cryptoDetailFunctionBloc.state).thenReturn(
          CryptoDetailFunctionLoadChartSuccess(
            lineChartType: LineChartType.chart7D,
            prices24H: Prices.fromJson(prices24h),
            prices7D: Prices.fromJson(prices7d),
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final customCryptoPriceLineChartFinder =
            tester.widget<CustomCryptoPriceLineChart>(
          find.byType(CustomCryptoPriceLineChart),
        );

        expect(customCryptoPriceLineChartFinder.lineChartType,
            LineChartType.chart7D);
      });
    });

    testWidgets(
        'Should display [thanksForYourVote] when crypto detail bloc state is [CryptoDetailFunctionLoadVotedSectionSuccess].',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));
        when(() => cryptoDetailFunctionBloc.state).thenReturn(
            const CryptoDetailFunctionLoadVotedSectionSuccess(isVoted: true));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final thanksForYourVoteFinder =
            find.text(constants.CryptoDetailScreen.thanksForYourVote);
        expect(thanksForYourVoteFinder, findsOneWidget);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionLoadedChart] event when [button7days] is tapped and crypto detail function bloc state is [CryptoDetailFunctionLoadSuccess].',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final textButtonFinder = find.ancestor(
          of: find.text(constants.CryptoDetailScreen.button7Days),
          matching: find.byType(TextButton),
        );

        expect(textButtonFinder, findsOneWidget);

        await tester.tap(textButtonFinder);
        await tester.pumpAndSettle();

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionLoadedChart(
                lineChartType: LineChartType.chart7D))).called(1);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionLoadedChart] event when [button24hours] is tapped and crypto detail function bloc state is [CryptoDetailFunctionLoadSuccess].',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final textButtonFinder = find.ancestor(
          of: find.text(constants.CryptoDetailScreen.button24Hours),
          matching: find.byType(TextButton),
        );

        expect(textButtonFinder, findsOneWidget);

        await tester.tap(textButtonFinder);
        await tester.pumpAndSettle();

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionLoadedChart(
                lineChartType: LineChartType.chart24H))).called(1);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionVoted] event when [sadEmojiTextButton] is tapped.',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

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

        verify(() => cryptoDetailFunctionBloc.add(CryptoDetailFunctionVoted()))
            .called(1);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionVoted] event when [smileEmojiTextButton] is tapped.',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

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

        verify(() => cryptoDetailFunctionBloc.add(CryptoDetailFunctionVoted()))
            .called(1);
      });
    });

    testWidgets(
        'Should render red priceChangePercentage24h when crypto detail bloc state is [CryptoDetailLoadSuccess]',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(
              json.decode(rawBitcoinWithNegativePriceChangePercentage24h)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(
              json.decode(rawBitcoinWithNegativePriceChangePercentage24h)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));
        final priceChangePercentage24h =
            '${CustomNumberFormat.customNumberFormatWithOneDecimalPlace(CryptoDetail.fromJson(json.decode(rawBitcoinWithNegativePriceChangePercentage24h)).marketData.priceChangePercentage24h)}%';
        await tester.pumpWidget(widget);
        await tester.pump();

        final priceChangePercentage24hFinder =
            find.text(priceChangePercentage24h);
        expect(
            (tester.widget(priceChangePercentage24hFinder) as Text)
                .style!
                .color,
            Colors.red.shade300);
      });
    });

    testWidgets(
        'Should render 2 CurrencyConverSionTextField widget when crypto detail bloc function state is [CryptoDetailFunctionLoadCurrencyConversionSectionSuccess]',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));
        when(() => cryptoDetailFunctionBloc.state).thenReturn(
            CryptoDetailFunctionLoadCurrencyConversionSectionSuccess(
          cryptoPriceTextField: 1.0,
          usdPriceTextField: 57778.0,
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
        ));

        await tester.pumpWidget(widget);
        await tester.pump();

        final currencyConverSionTextFieldFinder =
            find.byType(CurrencyConverSionTextField);
        expect(currencyConverSionTextFieldFinder, findsNWidgets(2));
      });
    });

    testWidgets(
        'Should render 1 chart widget when crypto detail bloc function state is [CryptoDetailFunctionLoadSuccess]',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart7D,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pump();

        final currencyConverSionTextFieldFinder =
            find.byType(CustomCryptoPriceLineChart);
        expect(currencyConverSionTextFieldFinder, findsOneWidget);
      });
    });

    testWidgets(
        'Should render 1 chart widget when crypto detail bloc function state is [CryptoDetailFunctionLoadChartSuccess]',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadChartSuccess(
          lineChartType: LineChartType.chart24H,
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));

        await tester.pumpWidget(widget);
        await tester.pump();

        final currencyConverSionTextFieldFinder =
            find.byType(CustomCryptoPriceLineChart);
        expect(currencyConverSionTextFieldFinder, findsOneWidget);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionLoadedChart] event when [button7days] is tapped and crypto detail function bloc state is [CryptoDetailFunctionLoadChartSuccess].',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadChartSuccess(
          lineChartType: LineChartType.chart7D,
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final textButtonFinder = find.ancestor(
          of: find.text(constants.CryptoDetailScreen.button7Days),
          matching: find.byType(TextButton),
        );

        expect(textButtonFinder, findsOneWidget);

        await tester.tap(textButtonFinder);
        await tester.pumpAndSettle();

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionLoadedChart(
                lineChartType: LineChartType.chart7D))).called(1);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionLoadedChart] event when [button24hours] is tapped and crypto detail function bloc state is [CryptoDetailFunctionLoadChartSuccess].',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadChartSuccess(
          lineChartType: LineChartType.chart24H,
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final textButtonFinder = find.ancestor(
          of: find.text(constants.CryptoDetailScreen.button24Hours),
          matching: find.byType(TextButton),
        );

        expect(textButtonFinder, findsOneWidget);

        await tester.tap(textButtonFinder);
        await tester.pumpAndSettle();

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionLoadedChart(
                lineChartType: LineChartType.chart24H))).called(1);
      });
    });

    testWidgets('Should refresh when scroll down the screen.', (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final textFinder = find.text(
            '\$${CustomNumberFormat.customNumberFormatWithCommas(CryptoDetail.fromJson(json.decode(rawBitcoin)).marketData.currentPrice.usdPrice)}');

        await tester.fling(textFinder, const Offset(0.0, 100.0), 1000.0);
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));

        verify(() => cryptoDetailBloc
            .add(const CryptoDetailStarted(cryptoId: 'bitcoin'))).called(2);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionChangedCryptoTextField] when enter text into [crypto CurrencyConverSionTextField] and crypto detail function bloc state is [CryptoDetailFunctionLoadSuccess].',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final currencyConverSionTextFieldFinder =
            find.byType(CurrencyConverSionTextField).first;

        await tester.enterText(currencyConverSionTextFieldFinder, '1');

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionChangedCryptoTextField(
                cryptoTextFieldValue: 1.0))).called(1);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionChangedUsdTextField] when enter text into [usd CurrencyConverSionTextField] and crypto detail function bloc state is [CryptoDetailFunctionLoadSuccess] .',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final currencyConverSionTextFieldFinder =
            find.byType(CurrencyConverSionTextField).last;

        await tester.enterText(currencyConverSionTextFieldFinder, '57778');

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionChangedUsdTextField(
                usdTextFieldValue: 57778.0))).called(1);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionChangedCryptoTextField] when enter text into [crypto CurrencyConverSionTextField] and crypto detail function bloc state is [CryptoDetailFunctionLoadCurrencyConversionSectionSuccess].',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state).thenReturn(
            CryptoDetailFunctionLoadCurrencyConversionSectionSuccess(
          cryptoPriceTextField: 1.0,
          usdPriceTextField: 57778.0,
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final currencyConverSionTextFieldFinder =
            find.byType(CurrencyConverSionTextField).first;

        await tester.enterText(currencyConverSionTextFieldFinder, '1');

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionChangedCryptoTextField(
                cryptoTextFieldValue: 1.0))).called(1);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionChangedUsdTextField] when enter text into [usd CurrencyConverSionTextField] and crypto detail function bloc state is [CryptoDetailFunctionLoadCurrencyConversionSectionSuccess] .',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state).thenReturn(
            CryptoDetailFunctionLoadCurrencyConversionSectionSuccess(
          cryptoPriceTextField: 1.0,
          usdPriceTextField: 57778.0,
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final currencyConverSionTextFieldFinder =
            find.byType(CurrencyConverSionTextField).last;

        await tester.enterText(currencyConverSionTextFieldFinder, '57778');

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionChangedUsdTextField(
                usdTextFieldValue: 57778.0))).called(1);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionChangedUsdTextField] when enter text [acb] into [usd CurrencyConverSionTextField] and crypto detail function bloc state is [CryptoDetailFunctionLoadSuccess] .',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state)
            .thenReturn(CryptoDetailFunctionLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
          isVoted: false,
          lineChartType: LineChartType.chart24H,
          usdPriceTextField: 57778,
          cryptoPriceTextField: 1.0,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final currencyConverSionTextFieldFinder =
            find.byType(CurrencyConverSionTextField).last;

        await tester.enterText(currencyConverSionTextFieldFinder, 'abc');

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionChangedUsdTextField(
                usdTextFieldValue: 57778.0))).called(1);
      });
    });

    testWidgets(
        'Should call [CryptoDetailFunctionChangedUsdTextField] when enter text [acb] into [usd CurrencyConverSionTextField] and crypto detail function bloc state is [CryptoDetailFunctionLoadCurrencyConversionSectionSuccess] .',
        (tester) async {
      await mockNetworkImages(() async {
        when(() => cryptoDetailService.fetchCryptoDetail('bitcoin'))
            .thenAnswer((_) async => cryptoDetail);
        when(() => pricesService.fetchPrices('bitcoin', 1))
            .thenAnswer((_) async => prices24h);
        when(() => pricesService.fetchPrices('bitcoin', 7))
            .thenAnswer((_) async => prices7d);
        when(() => cryptoDetailBloc.state).thenReturn(CryptoDetailLoadSuccess(
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
          prices24H: Prices.fromJson(json.decode(rawDatas24H)),
          prices7D: Prices.fromJson(json.decode(rawData7D)),
        ));
        when(() => cryptoDetailFunctionBloc.state).thenReturn(
            CryptoDetailFunctionLoadCurrencyConversionSectionSuccess(
          cryptoPriceTextField: 1.0,
          usdPriceTextField: 57778.0,
          cryptoDetail: CryptoDetail.fromJson(json.decode(rawBitcoin)),
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        final currencyConverSionTextFieldFinder =
            find.byType(CurrencyConverSionTextField).last;

        await tester.enterText(currencyConverSionTextFieldFinder, 'abc');

        verify(() => cryptoDetailFunctionBloc.add(
            const CryptoDetailFunctionChangedUsdTextField(
                usdTextFieldValue: 57778.0))).called(1);
      });
    });
  });
}
