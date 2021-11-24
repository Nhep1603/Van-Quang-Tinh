import 'package:bloc/bloc.dart';

import '../../services/crypto_currency_service/crypto_currency_service.dart';
import './crypto_currency_event.dart';
import './crypto_currency_state.dart';

class CryptoCurrencyBloc
    extends Bloc<CryptoCurrencyEvent, CryptoCurrencyState> {
  final CryptoCurrencyService service;
  int page = 1;
  int limit = 20;

  CryptoCurrencyBloc({required this.service}) : super(CryptoCurrencyInitial()) {
    on<CryptoCurrencyRequested>((event, emit) async {
      emit(CryptoCurrencyLoadInProgress());
      try { 
        final cryptos = await service.fetchCryptoCurrency(page);
        emit(CryptoCurrencyLoadSucess(cryptos: cryptos));
      } catch (e) {
        emit(CryptoCurrencyLoadFailure(errorMessage: e.toString()));
      }
    });
  }
}
