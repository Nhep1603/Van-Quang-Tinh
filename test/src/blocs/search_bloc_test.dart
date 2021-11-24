import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:van_quang_tinh/src/blocs/category/category_event.dart';
import 'package:van_quang_tinh/src/blocs/search/search_bloc.dart';
import 'package:van_quang_tinh/src/blocs/search/search_event.dart';
import 'package:van_quang_tinh/src/blocs/search/search_state.dart';
import 'package:van_quang_tinh/src/services/crypto_currency/crypto_currency_service.dart';

class MockSearchService extends Mock implements CryptoCurrencyService {}

class MockCategoryEvent extends CategoryEvent {}

main() {
  CryptoCurrencyService cryptoService;
  SearchBloc? searchBloc;

  setUp(() {
    cryptoService = MockSearchService();
    searchBloc = SearchBloc(service: cryptoService);
  });

  tearDown(() {
    searchBloc?.close();
  });

  blocTest('emits [] when no event is added',
      build: () => SearchBloc(), expect: () => []);

  blocTest(
    'emits [SearchLoadInProgress] then [SearchLoadSucess] when [SearchRequested] is called',
    build: () {
      cryptoService = MockSearchService();
      return SearchBloc(service: cryptoService);
    },
    act: (SearchBloc bloc) => bloc.add(SearchRequested()),
    expect: () => [
      SearchLoadInProgress(),
      SearchLoadSucess(),
    ],
  );

  blocTest(
    'emits [SearchLoadFailure] when [SearchRequested] is called and service throws error.',
    build: () {
      cryptoService = MockSearchService();
      when(cryptoService.fetchAllCryptoCurrency()).thenThrow(Exception());
      return SearchBloc(service: cryptoService);
    },
    act: (SearchBloc bloc) => bloc.add(SearchRequested()),
    expect: () => [
      SearchLoadInProgress(),
      SearchLoadFailure(errorMessage: Exception().toString()),
    ],
  );
}
