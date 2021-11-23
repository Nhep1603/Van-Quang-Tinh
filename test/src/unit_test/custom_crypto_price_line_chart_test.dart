import 'dart:convert';

import 'package:test/test.dart';
import 'package:van_quang_tinh/src/enum/line_chart_enum.dart';
import 'package:van_quang_tinh/src/models/prices.dart';
import 'package:van_quang_tinh/src/widgets/custom_crypto_price_line_chart.dart';

import '../../mock_data/line_chart_data.dart';

void main() {
  group('Line chart testing for displaying last 24 hours', () {
    final prices = Prices.fromJson(json.decode(rawDatas24H));
    final lineChart = CustomCryptoPriceLineChart(
      prices: prices,
      lineChartType: LineChartType.chart24H,
    );

    test('Should return a flSpot list', () {
      expect(lineChart.getFlSpots(), flSpots24h);
    });

    test('Should return the max price', () {
      expect(lineChart.getMaxPrice(), 66359.45415331505);
    });

    test('Should return the min price', () {
      expect(lineChart.getMinPrice(), 60588.17765644732);
    });

    test('Should return the min index for time displaying', () {
      expect(lineChart.getMinTimeIndexDisplay(), 1636990157754.0);
    });

    test('Should return the max index for time displaying', () {
      expect(lineChart.getMaxTimeIndexDisplay(), 1637020198150.0);
    });
  });

  group('Line chart testing for displaying last 7 days', () {
    final prices = Prices.fromJson(json.decode(rawData7D));
    final lineChart = CustomCryptoPriceLineChart(
      prices: prices,
      lineChartType: LineChartType.chart7D,
    );

    test('Should return a flSpot list', () {
      expect(lineChart.getFlSpots(), flSpots7d);
    });

    test('Should return the max price', () {
      expect(lineChart.getMaxPrice(), 68640.16034986946);
    });

    test('Should return the min price', () {
      expect(lineChart.getMinPrice(), 60335.052943455375);
    });

    test('Should return the min index for time displaying', () {
      expect(lineChart.getMinTimeIndexDisplay(), 1636682466391.0);
    });

    test('Should return the max index for time displaying', () {
      expect(lineChart.getMaxTimeIndexDisplay(), 1637042639664.0);
    });
  });
}
