import 'package:intl/intl.dart';

class CustomNumberFormat {
  static NumberFormat customNumberFormat = NumberFormat("#,###.00", "en_US");
  static NumberFormat customNumberFormatWithoutCommas = NumberFormat("#.00", "en_US");
}