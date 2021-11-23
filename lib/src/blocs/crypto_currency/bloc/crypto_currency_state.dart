import 'package:equatable/equatable.dart';

import '../../../models/crypto.dart';

abstract class CryptoCurrencyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CryptoCurrencyInitial extends CryptoCurrencyState {}

class CryptoCurrencyLoadInProgress extends CryptoCurrencyState {}

class CryptoCurrencyLoadFailure extends CryptoCurrencyState {
  final String? errorMessage;

  CryptoCurrencyLoadFailure({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class CryptoCurrencyLoadSucess extends CryptoCurrencyState {
  final List<Crypto>? cryptos;

  CryptoCurrencyLoadSucess({this.cryptos});

  @override
  List<Object?> get props => [cryptos];
}
