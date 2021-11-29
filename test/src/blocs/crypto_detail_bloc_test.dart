import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:van_quang_tinh/src/models/crypto_detail.dart';
import 'package:van_quang_tinh/src/models/prices.dart';
import 'package:van_quang_tinh/src/services/crypto_detail/crypto_detail_service.dart';
import 'package:van_quang_tinh/src/services/prices/prices_service.dart';
import '../../mock_data/crypto_detail_data.dart';
import '../../mock_data/line_chart_data.dart';

class MockCryptoDetailService extends Mock implements CryptoDetailService {}

class MockPricesService extends Mock implements PricesService {}

class MockCryptoDetailEvent extends CryptoDetailEvent {}

void main() {
  CryptoDetailService cryptoDetailService;
  PricesService pricesService;
  CryptoDetailBloc? cryptoDetailBloc;

  final cryptoDetail = CryptoDetail.fromJson(json.decode(rawBitcoin));
  final prices24h = Prices.fromJson(json.decode(rawDatas24H));
  final prices7d = Prices.fromJson(json.decode(rawData7D));

  setUp(() {
    cryptoDetailService = MockCryptoDetailService();
    pricesService = MockPricesService();
    cryptoDetailBloc = CryptoDetailBloc(
      cryptoDetailService: cryptoDetailService,
      pricesService: pricesService,
    );
  });

  tearDown(() {
    cryptoDetailBloc?.close();
  });

  blocTest(
    'emits [] when no event is added',
    build: () {
      cryptoDetailService = MockCryptoDetailService();
      pricesService = MockPricesService();
      return CryptoDetailBloc(
        cryptoDetailService: cryptoDetailService,
        pricesService: pricesService,
      );
    },
    expect: () => [],
  );

  blocTest(
    'emits [CryptoDetailLoadInProgress] then [CryptoDetailLoadSucess] when [CryptoDetailStarted] is called',
    build: () {
      cryptoDetailService = MockCryptoDetailService();
      pricesService = MockPricesService();
      when(cryptoDetailService.fetchCryptoDetail('bitcoin'))
          .thenAnswer((_) async => cryptoDetail);
      when(pricesService.fetchPrices('bitcoin', 1))
          .thenAnswer((_) async => prices24h);
      when(pricesService.fetchPrices('bitcoin', 7))
          .thenAnswer((_) async => prices7d);
      return CryptoDetailBloc(
        cryptoDetailService: cryptoDetailService,
        pricesService: pricesService,
      );
    },
    act: (CryptoDetailBloc bloc) =>
        bloc.add(const CryptoDetailStarted(cryptoId: 'bitcoin')),
    expect: () => [
      CryptoDetailLoadInProgress(),
      CryptoDetailLoadSuccess(
        cryptoDetail: cryptoDetail,
        prices24H: prices24h,
        prices7D: prices7d,
      ),
    ],
  );

  blocTest(
    'emits [CryptoDetailLoadInProgress] then [CryptoDetailLoadFailure] when [CryptoDetailStarted] is called',
    build: () {
      cryptoDetailService = MockCryptoDetailService();
      pricesService = MockPricesService();
      when(cryptoDetailService.fetchCryptoDetail('bitcoin'))
          .thenThrow(Exception());
      return CryptoDetailBloc(
        cryptoDetailService: cryptoDetailService,
        pricesService: pricesService,
      );
    },
    act: (CryptoDetailBloc bloc) =>
        bloc.add(const CryptoDetailStarted(cryptoId: 'bitcoin')),
    expect: () => [
      CryptoDetailLoadInProgress(),
      CryptoDetailLoadFailure(errorMessage: Exception().toString()),
    ],
  );
}
