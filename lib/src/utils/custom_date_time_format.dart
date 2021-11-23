import 'package:intl/intl.dart';

class CustomDateTimeFormat {
  static String millisecondsToHourAndMinuteFormatString(String lastModified) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(lastModified));
    return DateFormat('HH:mm').format(dateTime);
  }

  static String millisecondsToDayFormatString(String lastModified) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(lastModified));
    return DateFormat('dd. MMM').format(dateTime);
  }

  static String millisecondsToHourFormatString(String lastModified) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(lastModified));
    return DateFormat('HH').format(dateTime);
  }
}