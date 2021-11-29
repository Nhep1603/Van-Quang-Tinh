import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'package:van_quang_tinh/src/blocs/crypto_currency/crypto_currency_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_currency/crypto_currency_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_currency/crypto_currency_state.dart';
import 'package:van_quang_tinh/src/models/crypto.dart';
import 'package:van_quang_tinh/src/services/crypto_currency/crypto_currency_service.dart';
import '../../mock_data/crypto_currency_data.dart';

class MockCryptoService extends Mock implements CryptoCurrencyService {}

main() {
  dynamic mockResponse = json.decode(mockCryptoCurrencyData);

  CryptoCurrencyService cryptoCurrencyService;
  CryptoCurrencyBloc? cryptoBloc;

  blocTest('emits [] when no event is added',
      build: () {
        cryptoCurrencyService = MockCryptoService();
        return CryptoCurrencyBloc(service: cryptoCurrencyService);
      },
      expect: () => []);

  blocTest(
    'emits [CryptoCurrencyLoadInProgress] then [CryptoCurrencyLoadSucess] when [CryptoCurrencyRequested] is called',
    build: () {
      cryptoCurrencyService = MockCryptoService();
      when(cryptoCurrencyService.fetchCryptoCurrency(1))
          .thenAnswer((_) async => []);
      return CryptoCurrencyBloc(service: cryptoCurrencyService);
    },
    act: (CryptoCurrencyBloc bloc) =>
        bloc.add(CryptoCurrencyRequested(isRefesh: false)),
    expect: () => [
      CryptoCurrencyLoadInProgress(),
      CryptoCurrencyLoadSuccess(cryptos: const [], isLoading: true),
    ],
  );

  blocTest(
    'emits [CryptoCurrencyLoadFailure] when [CryptoCurrencyRequested] is called and service throws error.',
    build: () {
      cryptoCurrencyService = MockCryptoService();
      when(cryptoCurrencyService.fetchCryptoCurrency(1)).thenThrow(Exception());
      return CryptoCurrencyBloc(service: cryptoCurrencyService);
    },
    act: (CryptoCurrencyBloc bloc) =>
        bloc.add(CryptoCurrencyRequested(isRefesh: false)),
    expect: () => [
      CryptoCurrencyLoadInProgress(),
      CryptoCurrencyLoadFailure(errorMessage: Exception().toString()),
    ],
  );

   blocTest(
    'emits [CryptoCurrencyLoadSucess] when [CryptoCurrencyRequested] is called and [isRefesh] is true',
    build: () {
      cryptoCurrencyService = MockCryptoService();
      when(cryptoCurrencyService.fetchCryptoCurrency(1)).thenAnswer((_) async => []);
      return CryptoCurrencyBloc(service: cryptoCurrencyService);
    },
    act: (CryptoCurrencyBloc bloc) => bloc.add(CryptoCurrencyRequested(isRefesh: true)),
    expect: () => [
      CryptoCurrencyLoadInProgress(),
      CryptoCurrencyLoadSuccess(cryptos: const [], isLoading: true)
    ],
  );

  blocTest(
    'emits [CryptoCurrencyLoadSucess] when [CryptoCurrencyLoadMore] is called',
    build: () {
      cryptoCurrencyService = MockCryptoService();
      when(cryptoCurrencyService.fetchCryptoCurrency(1))
          .thenAnswer((_) async => []);
      when(cryptoCurrencyService.fetchCryptoCurrency(2))
          .thenAnswer((_) async => []);
      return CryptoCurrencyBloc(service: cryptoCurrencyService);
    },
    act: (CryptoCurrencyBloc bloc) => bloc
      ..add(CryptoCurrencyRequested(isRefesh: false))
      ..add(CryptoCurrencyLoadMore()),
    expect: () => [
      CryptoCurrencyLoadInProgress(),
      CryptoCurrencyLoadSuccess(cryptos: const [], isLoading: true),
      CryptoCurrencyLoadSuccess(cryptos: const [], isLoading: false),
      CryptoCurrencyLoadSuccess(cryptos: const [], isLoading: true)
    ],
  );

  blocTest(
    'emits [CryptoCurrencyLoadFailure] when [CryptoCurrencyLoadMore] is called and service throws error.',
    build: () {
      cryptoCurrencyService = MockCryptoService();
      when(cryptoCurrencyService.fetchCryptoCurrency(1))
          .thenAnswer((_) async => []);
      when(cryptoCurrencyService.fetchCryptoCurrency(2)).thenThrow(Exception());
      return CryptoCurrencyBloc(service: cryptoCurrencyService);
    },
    act: (CryptoCurrencyBloc bloc) => bloc
      ..add(CryptoCurrencyRequested(isRefesh: false))
      ..add(CryptoCurrencyLoadMore()),
    expect: () => [
      CryptoCurrencyLoadInProgress(),
      CryptoCurrencyLoadSuccess(cryptos: const [], isLoading: true),
      CryptoCurrencyLoadFailure(errorMessage: Exception().toString()),
    ],
  );

  blocTest(
    'emits [CryptoCurrencyLoadSucess] when [CryptoCurrencyLoadMore] is length of list crypto >= 300',
    build: () {
      for (var i = 0; i < 198; i++) {
        mockResponse += json.decode(mockCryptoCurrencyData);
      }
      cryptoCurrencyService = MockCryptoService();
      when(cryptoCurrencyService.fetchCryptoCurrency(1)).thenAnswer((_) async =>
          List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model))));
      when(cryptoCurrencyService.fetchCryptoCurrency(2))
          .thenAnswer((_) async => []);
      return CryptoCurrencyBloc(service: cryptoCurrencyService);
    },
    act: (CryptoCurrencyBloc bloc) => bloc
      ..add(CryptoCurrencyRequested(isRefesh: false))
      ..add(CryptoCurrencyLoadMore()),
    expect: () => [
      CryptoCurrencyLoadInProgress(),
      CryptoCurrencyLoadSuccess(
          cryptos: List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model))),
          isLoading: true),
      CryptoCurrencyLoadSuccess(
          cryptos: List<Crypto>.from(
              mockResponse.map((model) => Crypto.fromJson(model))),
          isLoading: false),
    ],
  );
}
