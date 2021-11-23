import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart' as constants;
import '../enum/line_chart_enum.dart';
import '../models/prices.dart';
import '../utils/custom_date_time_format.dart';
import '../utils/custom_number_format.dart';

class CustomCryptoPriceLineChart extends StatelessWidget {
  const CustomCryptoPriceLineChart({
    Key? key,
    required this.prices,
    required this.lineChartType,
  }) : super(key: key);

  final Prices prices;
  final LineChartType lineChartType;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: getMinTimeIndexDisplay(),
        maxX: getMaxTimeIndexDisplay(),
        minY: getMinPrice(),
        maxY: getMaxPrice(),
        titlesData: getTitleData(getMinPrice(), getMaxPrice()),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: constants.ColorConstants.criptoPriceLineChartFlLineColor,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: getFlSpots(),
            dotData: FlDotData(show: false),
            isCurved: true,
            colors: constants
                .ColorConstants.criptoPriceLineChartGradientColorsLine
                .map((color) => color.withOpacity(0.5))
                .toList(),
            belowBarData: BarAreaData(
              show: true,
              colors: constants
                  .ColorConstants.criptoPriceLineChartGradientColors
                  .map((map) => map.withOpacity(0.4))
                  .toList(),
              gradientFrom: const Offset(1, 1),
              gradientTo: const Offset(1, 0),
            ),
          ),
        ],
      ),
    );
  }

  getTitleData(double minPrice, double maxPrice) {
    return FlTitlesData(
      show: true,
      topTitles: SideTitles(
        showTitles: false,
      ),
      rightTitles: SideTitles(
        showTitles: false,
      ),
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff68737d),
          fontWeight: FontWeight.w500,
          fontSize: 12.0,
        ),
        getTitles: (value) {
          return CustomDateTimeFormat.millisecondsToHourAndMinuteFormatString(
              value.toInt().toString());
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        reservedSize: 70.0,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff68737d),
          fontWeight: FontWeight.w500,
          fontSize: 12.0,
        ),
        getTitles: (value) {
          if (minPrice == value || maxPrice == value) {
            return '';
          } else {
            return '\$${CustomNumberFormat.customNumberFormatWithCommas(value)}';
          }
        },
      ),
    );
  }

  getFlSpots() {
    List<FlSpot> flSpots = [];
    for (var i = 0; i < prices.prices.length; i++) {
      final price = prices.prices[i];
      for (var j = 0; j < 1; j++) {
        flSpots.add(FlSpot(
            double.tryParse(price[j].toString()) ?? getMinTimeIndexDisplay(),
            double.tryParse(price[j + 1].toString()) ?? getMaxPrice()));
      }
    }
    return flSpots;
  }

  getMinTimeIndexDisplay() {
    List<FlSpot> flSpots = getFlSpots();
    if (lineChartType == LineChartType.chart24H) {
      return flSpots.elementAt(100).x;
    } else {
      return flSpots.elementAt(60).x;
    }
  }

  getMaxTimeIndexDisplay() {
    List<FlSpot> flSpots = getFlSpots();
    if (lineChartType == LineChartType.chart24H) {
      return flSpots.elementAt(200).x;
    } else {
      return flSpots.elementAt(160).x;
    }
  }

  getMinPrice() {
    List<FlSpot> flSpots = getFlSpots();
    double minPrice = flSpots.first.y;
    for (var i = 1; i < flSpots.length; i++) {
      if (minPrice > flSpots[i].y) {
        minPrice = flSpots[i].y;
      }
    }
    return minPrice;
  }

  getMaxPrice() {
    List<FlSpot> flSpots = getFlSpots();
    double maxPrice = flSpots.first.y;
    for (var i = 1; i < flSpots.length; i++) {
      if (maxPrice < flSpots[i].y) {
        maxPrice = flSpots[i].y;
      }
    }
    return maxPrice;
  }
}
