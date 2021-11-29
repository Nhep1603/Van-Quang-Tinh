import 'package:equatable/equatable.dart';

import '../../models/crypto_detail.dart';
import '../../models/prices.dart';

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

class CryptoDetailLoadSuccess extends CryptoDetailState {
  final CryptoDetail cryptoDetail;
  final Prices prices24H;
  final Prices prices7D;

  CryptoDetailLoadSuccess({
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
