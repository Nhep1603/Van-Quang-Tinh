import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail_function/crypto_detail_function_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail_function/crypto_detail_function_state.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail_function/crypto_detail_function_event.dart';
import 'package:van_quang_tinh/src/services/crypto_detail/crypto_detail_service.dart';
import 'package:van_quang_tinh/src/services/prices/prices_service.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyTypeFake extends Fake implements Route {}

class MockCryptoDetailService extends Mock implements CryptoDetailService {}

class MockPricesService extends Mock implements PricesService {}

class MockCryptoDetailBloc
    extends MockBloc<CryptoDetailEvent, CryptoDetailState>
    implements CryptoDetailBloc {}

class MockCryptoDetailFunctionBloc
    extends MockBloc<CryptoDetailFunctionEvent, CryptoDetailFunctionState>
    implements CryptoDetailFunctionBloc {}

class FakeCryptoDetailState extends Fake implements CryptoDetailState {}

class FakeCryptoDetailEvent extends Fake implements CryptoDetailEvent {}

class FakeCryptoDetailFunctionState extends Fake
    implements CryptoDetailFunctionState {}

class FakeCryptoDetailFunctionEvent extends Fake
    implements CryptoDetailFunctionEvent {}