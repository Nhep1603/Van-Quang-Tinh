import 'package:equatable/equatable.dart';

import '../../models/crypto.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadFailure extends SearchState {
  final String? errorMessage;

  SearchLoadFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class SearchLoadInProgress extends SearchState {}

class SearchLoadSuccess extends SearchState {
  final List<Crypto>? cryptos;
  SearchLoadSuccess({this.cryptos});

  @override
  List<Object?> get props => [cryptos];
}
