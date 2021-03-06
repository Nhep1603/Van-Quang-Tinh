import 'package:bloc/bloc.dart';

import './category_event.dart';
import './category_state.dart';
import '../../services/category/category_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService service;

  CategoryBloc({required this.service}) : super(CategoryInitial()) {
    on<CategoryRequested>((event, emit) async {
      try {
        emit(CategoryLoadInProgress());
        final categories = (await service.fetchCategory())!;
        emit(CategoryLoadSuccess(categories: categories));
      } catch (e) {
        emit(CategoryLoadFailure(errorMessage: e.toString()));
      }
    });
  }
}
