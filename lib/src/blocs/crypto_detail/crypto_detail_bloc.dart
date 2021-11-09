import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'crypto_detail_event.dart';
part 'crypto_detail_state.dart';

class CryptoDetailBloc extends Bloc<CryptoDetailEvent, CryptoDetailState> {
  CryptoDetailBloc() : super(CryptoDetailInitial()) {
    on<CryptoDetailEvent>((event, emit) {});
  }
}
