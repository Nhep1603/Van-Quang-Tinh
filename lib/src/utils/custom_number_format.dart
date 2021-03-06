import 'package:intl/intl.dart';

class CustomNumberFormat {
  static String customNumberFormatWithCommas(dynamic number) {
    return NumberFormat("#,###.00", "en_US").format(number);
  }

  static String customNumberFormatWithoutCommas(dynamic number) {
    return NumberFormat("0.00", "en_US").format(number);
  }

  static String customNumberFormatWithoutDots(dynamic number) {
    return NumberFormat("#,###", "en_US").format(number);
  }

  static String customNumberFormatWithOneDecimalPlace(dynamic number) {
    return NumberFormat("0.0", "en_US").format(number);
  }
}
