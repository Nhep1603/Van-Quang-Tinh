import 'package:bloc/bloc.dart';

import 'crypto_detail_event.dart';
import 'crypto_detail_state.dart';

class CryptoDetailBloc extends Bloc<CryptoDetailEvent, CryptoDetailState> {
  CryptoDetailBloc() : super(CryptoDetailInitial()) {
    on<CryptoDetailEvent>((event, emit) {});
  }
}
