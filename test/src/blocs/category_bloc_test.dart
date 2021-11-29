import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:van_quang_tinh/src/blocs/category/category_bloc.dart';
import 'package:van_quang_tinh/src/blocs/category/category_event.dart';
import 'package:van_quang_tinh/src/blocs/category/category_state.dart';
import 'package:van_quang_tinh/src/services/category/category_service.dart';

class MockCategoryService extends Mock implements CategoryService {}

main() {
  CategoryService categoryService;
  CategoryBloc? categoryBloc;

  setUp(() {
    categoryService = MockCategoryService();
    categoryBloc = CategoryBloc(service: categoryService);
  });

  tearDown(() {
    categoryBloc?.close();
  });

  blocTest('emits [] when no event is added',
      build: () => CategoryBloc(), expect: () => []);

  blocTest(
    'emits [CategoryLoadInProgress] then [CategoryLoadSucess] when [CategoryRequested] is called',
    build: () {
      categoryService = MockCategoryService();
      return CategoryBloc(service: categoryService);
    },
    act: (CategoryBloc bloc) => bloc.add(CategoryRequested()),
    expect: () => [
      CategoryLoadInProgress(),
      CategoryLoadSuccess(),
    ],
  );

  blocTest(
    'emits [CategoryLoadFailure] when [CategoryRequested] is called and service throws error.',
    build: () {
      categoryService = MockCategoryService();
      when(categoryService.fetchCategory()).thenThrow(Exception());
      return CategoryBloc(service: categoryService);
    },
    act: (CategoryBloc bloc) => bloc.add(CategoryRequested()),
    expect: () => [
      CategoryLoadInProgress(),
      CategoryLoadFailure(errorMessage: Exception().toString()),
    ],
  );
}
