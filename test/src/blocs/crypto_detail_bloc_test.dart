import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_bloc.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_event.dart';
import 'package:van_quang_tinh/src/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:van_quang_tinh/src/enum/line_chart_enum.dart';

void main() {
  CryptoDetailBloc? cryptoDetailBloc;

  setUp(() {
    cryptoDetailBloc = CryptoDetailBloc();
  });

  tearDown(() {
    cryptoDetailBloc!.close();
  });

  blocTest(
    'emits [] when no event is added',
    build: () => CryptoDetailBloc(),
    expect: () => [],
  );

  blocTest(
    'emits [CryptoDetailLoadSucess] when [CryptoDetailStarted] is called',
    build: () => CryptoDetailBloc(),
    act: (CryptoDetailBloc bloc) => bloc.add(CryptoDetailStarted()),
    expect: () => [CryptoDetailLoadSucess(isVoted: false, lineChartType: LineChartType.chart24H)],
  );

  blocTest(
    'emits [CryptoDetailLoadSucess] when [CryptoDetailVoted] is called',
    build: () => CryptoDetailBloc(),
    act: (CryptoDetailBloc bloc) => bloc.add(CryptoDetailVoted()),
    expect: () => [
      CryptoDetailLoadSucess(
        isVoted: true,
        lineChartType: LineChartType.chart24H,
      ),
    ],
  );

  blocTest(
    'emits [CryptoDetailLoadSucess] with [lineChartType: LineChartType.chart24H] when [CryptoDetailLoadedChart] is called',
    build: () => CryptoDetailBloc(),
    act: (CryptoDetailBloc bloc) => bloc.add(
        const CryptoDetailLoadedChart(lineChartType: LineChartType.chart24H)),
    expect: () => [
      CryptoDetailLoadSucess(
        isVoted: false,
        lineChartType: LineChartType.chart24H,
      ),
    ],
  );

  blocTest(
    'emits [CryptoDetailLoadSucess] with [lineChartType: LineChartType.chart7D] when [CryptoDetailLoadedChart] is called',
    build: () => CryptoDetailBloc(),
    act: (CryptoDetailBloc bloc) => bloc.add(
        const CryptoDetailLoadedChart(lineChartType: LineChartType.chart7D)),
    expect: () => [
      CryptoDetailLoadSucess(
        isVoted: false,
        lineChartType: LineChartType.chart7D,
      ),
    ],
  );
}
