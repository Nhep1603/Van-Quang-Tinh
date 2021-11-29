import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail_function/crypto_detail_function_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail_function/crypto_detail_function_state.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail_function/crypto_detail_function_event.dart';
import 'package:van_quang_tinh/src/enum/line_chart_enum.dart';
import 'package:van_quang_tinh/src/models/crypto_detail.dart';
import 'package:van_quang_tinh/src/models/prices.dart';
import '../../mock_data/line_chart_data.dart';

class MockCryptoDetailFunctionEvent extends CryptoDetailFunctionEvent {}

void main() {
  CryptoDetailFunctionBloc? cryptoDetailFunctionBloc;

  const bitcoin = CryptoDetail(
      id: 'bitcoin',
      symbol: 'btc',
      name: 'Bitcoin',
      image: CryptoImage(
          small:
              'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579'),
      marketData: CryptoMarketData(
        currentPrice: CryptoCurrentPrice(usdPrice: 57778),
        priceChangePercentage24h: 2.49494,
      ));
  final prices24h = Prices.fromJson(json.decode(rawDatas24H));

  setUp(() {
    cryptoDetailFunctionBloc = CryptoDetailFunctionBloc();
  });

  tearDown(() {
    cryptoDetailFunctionBloc?.close();
  });

  blocTest(
    'emits [] when no event is added',
    build: () => CryptoDetailFunctionBloc(),
    expect: () => [],
  );

  blocTest(
    'emits [CryptoDetailFunctionLoadSuccess] when [CryptoDetailFunctionStarted] is called',
    build: () => CryptoDetailFunctionBloc(),
    act: (CryptoDetailFunctionBloc bloc) =>
        bloc.add(CryptoDetailFunctionStarted(
      cryptoDetail: bitcoin,
      prices24H: prices24h,
      prices7D: prices24h,
    )),
    expect: () => [
      CryptoDetailFunctionLoadSuccess(
        cryptoDetail: bitcoin,
        prices24H: prices24h,
        prices7D: prices24h,
        isVoted: false,
        lineChartType: LineChartType.chart24H,
        usdPriceTextField: bitcoin.marketData.currentPrice.usdPrice.toDouble(),
        cryptoPriceTextField: 1.0,
      )
    ],
  );

  blocTest(
    'emits [CryptoDetailFunctionLoadCurrencyConversionSectionSuccess] when [CryptoDetailFunctionChangedUsdTextField] is called',
    build: () => CryptoDetailFunctionBloc(),
    act: (CryptoDetailFunctionBloc bloc) => bloc
      ..add(CryptoDetailFunctionStarted(
        cryptoDetail: bitcoin,
        prices24H: prices24h,
        prices7D: prices24h,
      ))
      ..add(const CryptoDetailFunctionChangedUsdTextField(
          usdTextFieldValue: 57778.0)),
    expect: () => [
      CryptoDetailFunctionLoadSuccess(
        cryptoDetail: bitcoin,
        prices24H: prices24h,
        prices7D: prices24h,
        isVoted: false,
        lineChartType: LineChartType.chart24H,
        usdPriceTextField: bitcoin.marketData.currentPrice.usdPrice.toDouble(),
        cryptoPriceTextField: 1.0,
      ),
      const CryptoDetailFunctionLoadCurrencyConversionSectionSuccess(
        cryptoPriceTextField: 1.0,
        usdPriceTextField: 57778.0,
        cryptoDetail: bitcoin,
      ),
    ],
  );

  blocTest(
    'emits [CryptoDetailFunctionLoadCurrencyConversionSectionSuccess] when [CryptoDetailFunctionChangedCryptoTextField] is called',
    build: () => CryptoDetailFunctionBloc(),
    act: (CryptoDetailFunctionBloc bloc) => bloc
      ..add(CryptoDetailFunctionStarted(
        cryptoDetail: bitcoin,
        prices24H: prices24h,
        prices7D: prices24h,
      ))
      ..add(const CryptoDetailFunctionChangedCryptoTextField(
          cryptoTextFieldValue: 1.0)),
    expect: () => [
      CryptoDetailFunctionLoadSuccess(
        cryptoDetail: bitcoin,
        prices24H: prices24h,
        prices7D: prices24h,
        isVoted: false,
        lineChartType: LineChartType.chart24H,
        usdPriceTextField: bitcoin.marketData.currentPrice.usdPrice.toDouble(),
        cryptoPriceTextField: 1.0,
      ),
      const CryptoDetailFunctionLoadCurrencyConversionSectionSuccess(
        cryptoPriceTextField: 1.0,
        usdPriceTextField: 57778.0,
        cryptoDetail: bitcoin,
      ),
    ],
  );

  blocTest(
    'emits [CryptoDetailFunctionLoadChartSuccess] when [CryptoDetailFunctionLoadedChart] is called',
    build: () => CryptoDetailFunctionBloc(),
    act: (CryptoDetailFunctionBloc bloc) => bloc
      ..add(CryptoDetailFunctionStarted(
        cryptoDetail: bitcoin,
        prices24H: prices24h,
        prices7D: prices24h,
      ))
      ..add(const CryptoDetailFunctionLoadedChart(
          lineChartType: LineChartType.chart24H)),
    expect: () => [
      CryptoDetailFunctionLoadSuccess(
        cryptoDetail: bitcoin,
        prices24H: prices24h,
        prices7D: prices24h,
        isVoted: false,
        lineChartType: LineChartType.chart24H,
        usdPriceTextField: bitcoin.marketData.currentPrice.usdPrice.toDouble(),
        cryptoPriceTextField: 1.0,
      ),
      CryptoDetailFunctionLoadChartSuccess(
        lineChartType: LineChartType.chart24H,
        prices24H: prices24h,
        prices7D: prices24h,
      ),
    ],
  );

  blocTest(
    'emits [CryptoDetailFunctionLoadVotedSectionSuccess] when [CryptoDetailFunctionVoted] is called',
    build: () => CryptoDetailFunctionBloc(),
    act: (CryptoDetailFunctionBloc bloc) => bloc
      ..add(CryptoDetailFunctionStarted(
        cryptoDetail: bitcoin,
        prices24H: prices24h,
        prices7D: prices24h,
      ))
      ..add(CryptoDetailFunctionVoted()),
    expect: () => [
      CryptoDetailFunctionLoadSuccess(
        cryptoDetail: bitcoin,
        prices24H: prices24h,
        prices7D: prices24h,
        isVoted: false,
        lineChartType: LineChartType.chart24H,
        usdPriceTextField: bitcoin.marketData.currentPrice.usdPrice.toDouble(),
        cryptoPriceTextField: 1.0,
      ),
      const CryptoDetailFunctionLoadVotedSectionSuccess(isVoted: true),
    ],
  );
}
