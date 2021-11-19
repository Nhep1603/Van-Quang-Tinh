import 'package:equatable/equatable.dart';

import '../../enum/line_chart_enum.dart';

abstract class CryptoDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CryptoDetailInitial extends CryptoDetailState {}

class CryptoDetailLoadFailure extends CryptoDetailState {
  final String? errorMessage;

  CryptoDetailLoadFailure({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}

class CryptoDetailLoadInProgress extends CryptoDetailState {}

class CryptoDetailLoadSucess extends CryptoDetailState {
  final bool isVoted;
  final LineChartType lineChartType;

  CryptoDetailLoadSucess({
    required this.isVoted,
    required this.lineChartType,
  });

  @override
  List<Object> get props => [isVoted, lineChartType];
}
