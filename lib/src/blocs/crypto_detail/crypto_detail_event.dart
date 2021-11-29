import 'package:equatable/equatable.dart';

abstract class CryptoDetailEvent extends Equatable {
  const CryptoDetailEvent();

  @override
  List<Object> get props => [];
}

class CryptoDetailStarted extends CryptoDetailEvent {
  final String cryptoId;

  const CryptoDetailStarted({
    required this.cryptoId,
  });

  @override
  List<Object> get props => [cryptoId];
}
