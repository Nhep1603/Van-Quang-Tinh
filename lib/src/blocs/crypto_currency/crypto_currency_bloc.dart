import 'package:bloc/bloc.dart';

import '../../models/crypto.dart';
import '../../services/crypto_currency/crypto_currency_service.dart';
import './crypto_currency_event.dart';
import './crypto_currency_state.dart';

class CryptoCurrencyBloc
    extends Bloc<CryptoCurrencyEvent, CryptoCurrencyState> {
  final CryptoCurrencyService service;
  late List<Crypto> _cryptos;
  late bool _isLoading;
  final int _max = 300;
  int _page = 1;

  CryptoCurrencyBloc({required this.service}) : super(CryptoCurrencyInitial()) {
    on<CryptoCurrencyRequested>((event, emit) async {
      emit(CryptoCurrencyLoadInProgress());
      try {
        if (event.isRefesh) {
          _page = 1;
        }
        _cryptos = (await service.fetchCryptoCurrency(_page))!;
        _isLoading = true;
        emit(CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: _isLoading));
        _page++;
      } catch (e) {
        emit(CryptoCurrencyLoadFailure(errorMessage: e.toString()));
      }
    });

    on<CryptoCurrencyLoadMore>((event, emit) async {
      try {
        if (_cryptos.length >= _max) {
          _isLoading = false;
          emit(CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: _isLoading));
        } else {
          final cryptosFromAPI = await service.fetchCryptoCurrency(_page);
          _cryptos.addAll(cryptosFromAPI!);
          _isLoading = false;
          emit(CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: _isLoading));

          _isLoading = true;
          emit(CryptoCurrencyLoadSuccess(cryptos: _cryptos, isLoading: _isLoading));
          _page++;
        }
      } catch (e) {
        emit(CryptoCurrencyLoadFailure(errorMessage: e.toString()));
      }
    });
  }
}
