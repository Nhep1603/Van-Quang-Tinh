import 'package:bloc/bloc.dart';
import '../../services/crypto_currency/crypto_currency_service.dart';

import './search_event.dart';
import './search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CryptoCurrencyService? service;

  SearchBloc({this.service}) : super(SearchInitial()) {
    on<SearchRequested>((event, emit) async {
      try {
        emit(SearchLoadInProgress());
        emit(SearchLoadSucess(cryptos: await service!.fetchAllCryptoCurrency()));
      } catch (e) {
        emit(SearchLoadFailure(errorMessage: e.toString()));
      }
    });
  }
}