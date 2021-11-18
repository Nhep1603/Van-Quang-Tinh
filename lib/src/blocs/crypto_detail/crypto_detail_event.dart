import 'package:equatable/equatable.dart';

import '../../enum/line_chart_enum.dart';

abstract class CryptoDetailEvent extends Equatable {
  const CryptoDetailEvent();

  @override
  List<Object> get props => [];
}

class CryptoDetailStarted extends CryptoDetailEvent {}

class CryptoDetailVoted extends CryptoDetailEvent {}

class CryptoDetailLoadedChart extends CryptoDetailEvent {
  final LineChartType lineChartType;
  
  const CryptoDetailLoadedChart({
    required this.lineChartType,
  });
}
