import 'package:equatable/equatable.dart';

abstract class CryptoCurrencyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CryptoCurrencyRequested extends CryptoCurrencyEvent {
  final bool isRefesh;
  CryptoCurrencyRequested({required this.isRefesh});

  @override
  List<Object> get props => [isRefesh];
}

class CryptoCurrencyLoadMore extends CryptoCurrencyEvent {}
