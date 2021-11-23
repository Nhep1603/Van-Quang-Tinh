import 'package:bloc/bloc.dart';

import '../../enum/line_chart_enum.dart';
import './crypto_detail_event.dart';
import './crypto_detail_state.dart';

class CryptoDetailBloc extends Bloc<CryptoDetailEvent, CryptoDetailState> {
  bool _isVoted = false;
  LineChartType _lineChartType = LineChartType.chart24H;

  CryptoDetailBloc() : super(CryptoDetailInitial()) {
    on<CryptoDetailStarted>(_onStart);
    on<CryptoDetailVoted>(_onVote);
    on<CryptoDetailLoadedChart>(_onLoadChart);
  }

  _onStart(CryptoDetailStarted event, Emitter<CryptoDetailState> emit) {
    emit(CryptoDetailLoadSucess(
      isVoted: _isVoted,
      lineChartType: _lineChartType,
    ));
  }

  _onVote(CryptoDetailVoted event, Emitter<CryptoDetailState> emit) {
    _isVoted = true;
    emit(CryptoDetailLoadSucess(
      isVoted: _isVoted,
      lineChartType: _lineChartType,
    ));
  }

  _onLoadChart(CryptoDetailLoadedChart event, Emitter<CryptoDetailState> emit) {
    _lineChartType = event.lineChartType;
    emit(CryptoDetailLoadSucess(
      isVoted: _isVoted,
      lineChartType: _lineChartType,
    ));
  }
}
