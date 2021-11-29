import 'package:bloc/bloc.dart';

import './category_event.dart';
import './category_state.dart';
import '../../services/category/category_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService? service;

  CategoryBloc({this.service}) : super(CategoryInitial()) {
    on<CategoryRequested>((event, emit) async {
      try {
        emit(CategoryLoadInProgress());
        emit(CategoryLoadSuccess(categories: await service!.fetchCategory()));
      } catch (e) {
        emit(CategoryLoadFailure(errorMessage: e.toString()));
      }
    });
  }
}
