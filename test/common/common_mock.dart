import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:van_quang_tinh/src/blocs/category/category_bloc.dart';
import 'package:van_quang_tinh/src/blocs/category/category_event.dart';
import 'package:van_quang_tinh/src/blocs/category/category_state.dart';
import 'package:van_quang_tinh/src/services/category/category_service.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyTypeFake extends Fake implements Route {}

class MockCategoryBloc extends MockBloc<CategoryEvent, CategoryState>
    implements CategoryBloc {}

class MockCategoryService extends Mock implements CategoryService {}

class FakeCategoryState extends Fake implements CategoryState {}

class FakeCategoryEvent extends Fake implements CategoryEvent {}