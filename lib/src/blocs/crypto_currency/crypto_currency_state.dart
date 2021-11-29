import 'package:equatable/equatable.dart';

import '../../models/crypto.dart';

abstract class CryptoCurrencyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CryptoCurrencyInitial extends CryptoCurrencyState {}

class CryptoCurrencyLoadInProgress extends CryptoCurrencyState {}

class CryptoCurrencyLoadFailure extends CryptoCurrencyState {
  final String errorMessage;

  CryptoCurrencyLoadFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class CryptoCurrencyLoadSuccess extends CryptoCurrencyState {
  final List<Crypto> cryptos;
  final bool isLoading;

  CryptoCurrencyLoadSuccess({required this.cryptos,required this.isLoading});

  @override
  List<Object?> get props => [cryptos,isLoading];
}
