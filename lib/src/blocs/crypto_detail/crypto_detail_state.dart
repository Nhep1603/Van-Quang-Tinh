part of 'crypto_detail_bloc.dart';

abstract class CryptoDetailState extends Equatable {
  const CryptoDetailState();
  
  @override
  List<Object> get props => [];
}

class CryptoDetailInitial extends CryptoDetailState {}
