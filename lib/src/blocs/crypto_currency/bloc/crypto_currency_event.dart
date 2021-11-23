import 'package:equatable/equatable.dart';

abstract class CryptoCurrencyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CryptoCurrencyRequested extends CryptoCurrencyEvent {}
