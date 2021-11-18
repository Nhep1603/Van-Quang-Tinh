// ignore_for_file: annotate_overrides, overridden_fields

import 'package:equatable/equatable.dart';
import 'package:van_quang_tinh/src/enum/line_chart_enum.dart';

abstract class CryptoDetailState extends Equatable {
  final bool? isVoted;
  final LineChartType? lineChartType;

  const CryptoDetailState({
    this.isVoted = false,
    this.lineChartType = LineChartType.chart24H,
  });

  @override
  List<Object?> get props => [
        isVoted,
        lineChartType,
      ];
}

class CryptoDetailInitial extends CryptoDetailState {}

class CryptoDetailLoadFailure extends CryptoDetailState {
  final String? errorMessage;

  const CryptoDetailLoadFailure({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}

class CryptoDetailLoadInProgress extends CryptoDetailState {}

class CryptoDetailLoadSucess extends CryptoDetailState {
  final bool isVoted;
  final LineChartType lineChartType;

  const CryptoDetailLoadSucess({
    required this.isVoted,
    required this.lineChartType,
  }) : super(
          isVoted: isVoted,
          lineChartType: lineChartType,
        );

  @override
  List<Object> get props => [
        isVoted,
        lineChartType,
      ];
}
