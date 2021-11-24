import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:van_quang_tinh/src/blocs/crypto_currency/crypto_currency_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_currency/crypto_currency_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_currency/crypto_currency_state.dart';
import 'package:van_quang_tinh/src/services/crypto_currency_service/crypto_currency_service.dart';

class MockCryptoService extends Mock implements CryptoCurrencyService {}

main() {
  CryptoCurrencyService cryptoCurrencyService;
  CryptoCurrencyBloc? cryptoBloc;

  setUp(() {
    cryptoCurrencyService = MockCryptoService();
    cryptoBloc = CryptoCurrencyBloc(service: cryptoCurrencyService);
  });

  tearDown(() {
    cryptoBloc?.close();
  });

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
      return CryptoCurrencyBloc(service: cryptoCurrencyService);
    },
    act: (CryptoCurrencyBloc bloc) => bloc.add(CryptoCurrencyRequested()),
    expect: () => [
      CryptoCurrencyLoadInProgress(),
      CryptoCurrencyLoadSucess(),
    ],
  );

  blocTest(
    'emits [CryptoCurrencyLoadFailure] when [CryptoCurrencyRequested] is called and service throws error.',
    build: () {
      cryptoCurrencyService = MockCryptoService();
      when(cryptoCurrencyService.fetchCryptoCurrency(1)).thenThrow(Exception());
      return CryptoCurrencyBloc(service: cryptoCurrencyService);
    },
    act: (CryptoCurrencyBloc bloc) => bloc.add(CryptoCurrencyRequested()),
    expect: () => [
      CryptoCurrencyLoadInProgress(),
      CryptoCurrencyLoadFailure(errorMessage: Exception().toString()),
    ],
  );
}
