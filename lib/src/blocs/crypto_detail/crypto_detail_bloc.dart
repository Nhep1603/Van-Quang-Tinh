import 'package:bloc/bloc.dart';

import '../../models/crypto_detail.dart';
import '../../models/prices.dart';
import '../../services/crypto_detail/crypto_detail_service.dart';
import '../../services/prices/prices_service.dart';
import './crypto_detail_event.dart';
import './crypto_detail_state.dart';

class CryptoDetailBloc extends Bloc<CryptoDetailEvent, CryptoDetailState> {
  final CryptoDetailService cryptoDetailService;
  final PricesService pricesService;

  late CryptoDetail _cryptoDetail;
  late Prices _prices24H;
  late Prices _prices7D;

  CryptoDetailBloc({
    required this.cryptoDetailService,
    required this.pricesService,
  }) : super(CryptoDetailInitial()) {
    on<CryptoDetailStarted>(_onStart);
  }

  _onStart(CryptoDetailStarted event, Emitter<CryptoDetailState> emit) async {
    try {
      emit(CryptoDetailLoadInProgress());
      _cryptoDetail =
          await cryptoDetailService.fetchCryptoDetail(event.cryptoId)!;
      _prices24H = await pricesService.fetchPrices(event.cryptoId, 1)!;
      _prices7D = await pricesService.fetchPrices(event.cryptoId, 7)!;

      emit(CryptoDetailLoadSuccess(
        cryptoDetail: _cryptoDetail,
        prices24H: _prices24H,
        prices7D: _prices7D,
      ));
    } catch (e) {
      emit(CryptoDetailLoadFailure(errorMessage: e.toString()));
    }
  }
}
