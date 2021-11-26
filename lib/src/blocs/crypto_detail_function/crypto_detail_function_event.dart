import 'package:equatable/equatable.dart';

import '../../enum/line_chart_enum.dart';
import '../../models/crypto_detail.dart';
import '../../models/prices.dart';

abstract class CryptoDetailFunctionEvent extends Equatable {
  const CryptoDetailFunctionEvent();

  @override
  List<Object> get props => [];
}

class CryptoDetailFunctionStarted extends CryptoDetailFunctionEvent {
  final CryptoDetail cryptoDetail;
  final Prices prices24H;
  final Prices prices7D;

  const CryptoDetailFunctionStarted({
    required this.cryptoDetail,
    required this.prices24H,
    required this.prices7D,
  });

  @override
  List<Object> get props => [
        cryptoDetail,
        prices24H,
        prices7D,
      ];
}

class CryptoDetailFunctionChangedUsdTextField extends CryptoDetailFunctionEvent {
  final double usdTextFieldValue;

  const CryptoDetailFunctionChangedUsdTextField({
    required this.usdTextFieldValue,
  });

  @override
  List<Object> get props => [usdTextFieldValue];
}

class CryptoDetailFunctionChangedCryptoTextField extends CryptoDetailFunctionEvent {
  final double cryptoTextFieldValue;
  
  const CryptoDetailFunctionChangedCryptoTextField({
    required this.cryptoTextFieldValue,
  });

  @override
  List<Object> get props => [cryptoTextFieldValue];
}

class CryptoDetailFunctionLoadedChart extends CryptoDetailFunctionEvent {
  final LineChartType lineChartType;

  const CryptoDetailFunctionLoadedChart({
    required this.lineChartType,
  });

  @override
  List<Object> get props => [lineChartType];
}

class CryptoDetailFunctionVoted extends CryptoDetailFunctionEvent {}
