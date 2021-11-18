import 'package:bloc/bloc.dart';

import 'crypto_detail_event.dart';
import 'crypto_detail_state.dart';

class CryptoDetailBloc extends Bloc<CryptoDetailEvent, CryptoDetailState> {
  CryptoDetailBloc() : super(CryptoDetailInitial()) {
    on<CryptoDetailStarted>(_onStart);
    on<CryptoDetailVoted>(_onVote);
    on<CryptoDetailLoadedChart>(_onLoadChart);
  }

  _onStart(CryptoDetailStarted event, Emitter<CryptoDetailState> emit) {
    emit(CryptoDetailInitial());
  }

  _onVote(CryptoDetailVoted event, Emitter<CryptoDetailState> emit) {
    emit(CryptoDetailLoadSucess(
      isVoted: true,
      lineChartType: state.lineChartType!,
    ));
  }

  _onLoadChart(CryptoDetailLoadedChart event, Emitter<CryptoDetailState> emit) {
    emit(CryptoDetailLoadSucess(
      isVoted: state.isVoted!,
      lineChartType: event.lineChartType,
    ));
  }
}
