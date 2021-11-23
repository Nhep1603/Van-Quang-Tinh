import 'package:bloc/bloc.dart';

import '../../services/category/category_service.dart';
import './category_event.dart';
import './category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService? service;

  CategoryBloc({this.service}) : super(CategoryInitial()) {
    on<CategoryRequested>((event, emit) async {
      try {
        emit(CategoryLoadInProgress());
        emit(CategoryLoadSucess(categories: await service!.fetchCategory()));
      } catch (e) {
        emit(CategoryLoadFailure(errorMessage: e.toString()));
      }
    });
  }
}
