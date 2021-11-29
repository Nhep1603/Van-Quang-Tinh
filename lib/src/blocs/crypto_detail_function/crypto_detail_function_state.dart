import 'package:equatable/equatable.dart';

import '../../enum/line_chart_enum.dart';
import '../../models/crypto_detail.dart';
import '../../models/prices.dart';

abstract class CryptoDetailFunctionState extends Equatable {
  const CryptoDetailFunctionState();

  @override
  List<Object> get props => [];
}

class CryptoDetailFunctionInitial extends CryptoDetailFunctionState {}

class CryptoDetailFunctionLoadSuccess extends CryptoDetailFunctionState {
  final CryptoDetail cryptoDetail;
  final Prices prices24H;
  final Prices prices7D;
  final bool isVoted;
  final LineChartType lineChartType;
  final double cryptoPriceTextField;
  final double usdPriceTextField;

  const CryptoDetailFunctionLoadSuccess({
    required this.cryptoDetail,
    required this.prices24H,
    required this.prices7D,
    required this.isVoted,
    required this.lineChartType,
    required this.usdPriceTextField,
    required this.cryptoPriceTextField,
  });

  @override
  List<Object> get props => [
        cryptoDetail,
        prices24H,
        prices7D,
        isVoted,
        lineChartType,
        usdPriceTextField,
        cryptoPriceTextField,
      ];
}

class CryptoDetailFunctionLoadCurrencyConversionSectionSuccess
    extends CryptoDetailFunctionState {
  final double cryptoPriceTextField;
  final double usdPriceTextField;
  final CryptoDetail cryptoDetail;

  const CryptoDetailFunctionLoadCurrencyConversionSectionSuccess({
    required this.cryptoPriceTextField,
    required this.usdPriceTextField,
    required this.cryptoDetail,
  });

  @override
  List<Object> get props => [
        cryptoPriceTextField,
        usdPriceTextField,
        cryptoDetail,
      ];
}

class CryptoDetailFunctionLoadChartSuccess extends CryptoDetailFunctionState {
  final LineChartType lineChartType;
  final Prices prices24H;
  final Prices prices7D;
  
  const CryptoDetailFunctionLoadChartSuccess({
    required this.lineChartType,
    required this.prices24H,
    required this.prices7D,
  });

  @override
  List<Object> get props => [
        lineChartType,
        prices24H,
        prices7D,
      ];
}

class CryptoDetailFunctionLoadVotedSectionSuccess
    extends CryptoDetailFunctionState {
  final bool isVoted;

  const CryptoDetailFunctionLoadVotedSectionSuccess({
    required this.isVoted,
  });

  @override
  List<Object> get props => [isVoted];
}
