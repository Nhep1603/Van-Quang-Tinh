import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:van_quang_tinh/src/enum/line_chart_enum.dart';
import 'package:van_quang_tinh/src/models/prices.dart';
import 'package:van_quang_tinh/src/widgets/custom_crypto_price_line_chart.dart';
import '../../mock_data/line_chart_data.dart';

void main() {
  final prices = Prices.fromJson(json.decode(rawDatas24H));
  var widget = MaterialApp(
    home: CustomCryptoPriceLineChart(
      prices: prices,
      lineChartType: LineChartType.chart24H,
    ),
  );

  testWidgets('Should render a line chart', (tester) async {
    await tester.pumpWidget(widget);

    expect(find.byType(LineChart), findsOneWidget);
  });
}
