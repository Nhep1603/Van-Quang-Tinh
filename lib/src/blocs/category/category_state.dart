import 'package:equatable/equatable.dart';

import '../../models/category.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoadFailure extends CategoryState {
  final String? errorMessage;

  CategoryLoadFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class CategoryLoadInProgress extends CategoryState {}

class CategoryLoadSuccess extends CategoryState {
  final List<Category> categories;

  CategoryLoadSuccess({required this.categories});

  @override
  List<Object?> get props => [categories];
}
