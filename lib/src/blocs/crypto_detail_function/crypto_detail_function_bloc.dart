import 'package:bloc/bloc.dart';

import '../../enum/line_chart_enum.dart';
import '../../models/crypto_detail.dart';
import '../../models/prices.dart';
import './crypto_detail_function_event.dart';
import './crypto_detail_function_state.dart';

class CryptoDetailFunctionBloc
    extends Bloc<CryptoDetailFunctionEvent, CryptoDetailFunctionState> {
  late CryptoDetail _cryptoDetail;
  late Prices _prices24H;
  late Prices _prices7D;
  late double _usdPrice;
  late double _cryptoPrice;
  late bool _isVoted;
  late LineChartType _lineChartType;

  CryptoDetailFunctionBloc() : super(CryptoDetailFunctionInitial()) {
    on<CryptoDetailFunctionStarted>(_onStart);
    on<CryptoDetailFunctionChangedUsdTextField>(_onChangeUsdTextField);
    on<CryptoDetailFunctionChangedCryptoTextField>(_onChangeCryptoTextFiel);
    on<CryptoDetailFunctionLoadedChart>(_onLoadChart);
    on<CryptoDetailFunctionVoted>(_onVote);
  }

  _onStart(CryptoDetailFunctionStarted event,
      Emitter<CryptoDetailFunctionState> emit) {
    _cryptoDetail = event.cryptoDetail;
    _prices24H = event.prices24H;
    _prices7D = event.prices7D;
    _cryptoPrice = 1.0;
    _usdPrice = _cryptoDetail.marketData.currentPrice.usdPrice.toDouble();
    _isVoted = false;
    _lineChartType = LineChartType.chart24H;

    emit(CryptoDetailFunctionLoadSuccess(
      cryptoDetail: _cryptoDetail,
      prices24H: _prices24H,
      prices7D: _prices7D,
      isVoted: _isVoted,
      lineChartType: _lineChartType,
      cryptoPriceTextField: _cryptoPrice,
      usdPriceTextField: _usdPrice,
    ));
  }

  _onChangeUsdTextField(CryptoDetailFunctionChangedUsdTextField event,
      Emitter<CryptoDetailFunctionState> emit) {
    _cryptoPrice = event.usdTextFieldValue /
        _cryptoDetail.marketData.currentPrice.usdPrice.toDouble();
    _usdPrice = event.usdTextFieldValue;

    emit(CryptoDetailFunctionLoadCurrencyConversionSectionSuccess(
      cryptoPriceTextField: _cryptoPrice,
      usdPriceTextField: _usdPrice,
      cryptoDetail: _cryptoDetail,
    ));
  }

  _onChangeCryptoTextFiel(CryptoDetailFunctionChangedCryptoTextField event,
      Emitter<CryptoDetailFunctionState> emit) {
    _usdPrice = event.cryptoTextFieldValue *
        _cryptoDetail.marketData.currentPrice.usdPrice.toDouble();
    _cryptoPrice = event.cryptoTextFieldValue;

    emit(CryptoDetailFunctionLoadCurrencyConversionSectionSuccess(
      cryptoPriceTextField: _cryptoPrice,
      usdPriceTextField: _usdPrice,
      cryptoDetail: _cryptoDetail,
    ));
  }

  _onLoadChart(CryptoDetailFunctionLoadedChart event,
      Emitter<CryptoDetailFunctionState> emit) {
    _lineChartType = event.lineChartType;

    emit(CryptoDetailFunctionLoadChartSuccess(
      lineChartType: _lineChartType,
      prices24H: _prices24H,
      prices7D: _prices7D,
    ));
  }

  _onVote(CryptoDetailFunctionVoted event,
      Emitter<CryptoDetailFunctionState> emit) {
    _isVoted = true;
    
    emit(CryptoDetailFunctionLoadVotedSectionSuccess(
      isVoted: _isVoted,
    ));
  }
}
