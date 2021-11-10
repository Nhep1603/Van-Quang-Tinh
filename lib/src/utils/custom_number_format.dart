import 'package:intl/intl.dart';

class CustomNumberFormat {
  static NumberFormat customNumberFormat = NumberFormat("#,###.##", "en_US");
  static NumberFormat customNumberFormatWithoutCommas = NumberFormat("#.##", "en_US");

}