import 'package:equatable/equatable.dart';

abstract class CryptoDetailState extends Equatable {
  const CryptoDetailState();

  @override
  List<Object> get props => [];
}

class CryptoDetailInitial extends CryptoDetailState {}
