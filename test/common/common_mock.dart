import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:van_quang_tinh/src/blocs/category/category_bloc.dart';
import 'package:van_quang_tinh/src/blocs/category/category_event.dart';
import 'package:van_quang_tinh/src/blocs/category/category_state.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:van_quang_tinh/src/blocs/search/search_bloc.dart';
import 'package:van_quang_tinh/src/blocs/search/search_event.dart';
import 'package:van_quang_tinh/src/blocs/search/search_state.dart';
import 'package:van_quang_tinh/src/services/category/category_service.dart';
import 'package:van_quang_tinh/src/services/crypto_currency/crypto_currency_service.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyTypeFake extends Fake implements Route {}

class MockCategoryBloc extends MockBloc<CategoryEvent, CategoryState>
    implements CategoryBloc {}

class MockCategoryService extends Mock implements CategoryService {}

class FakeCategoryState extends Fake implements CategoryState {}

class FakeCategoryEvent extends Fake implements CategoryEvent {}

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class MockSearchService extends Mock implements CryptoCurrencyService {}

class FakeSearchState extends Fake implements SearchState {}

class FakeSearchEvent extends Fake implements SearchEvent {}

class RouteFake extends Fake implements Route {}

class MockCryptoDetailBloc
    extends MockBloc<CryptoDetailEvent, CryptoDetailState>
    implements CryptoDetailBloc {}

class FakeCryptoDetailState extends Fake implements CryptoDetailState {}

class FakeCryptoDetailEvent extends Fake implements CryptoDetailEvent {}
