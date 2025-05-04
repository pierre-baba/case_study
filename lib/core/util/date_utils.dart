import 'package:intl/intl.dart';

class DateUtils {
  static String getDayName(String date, {bool isFullName = false}) {
    try {
      final parsedDate = DateTime.tryParse(date.trim());
      if (parsedDate == null) return "";
      return DateFormat(isFullName ? 'EEEE' : "EEE").format(parsedDate);
    } catch (e) {
      return "";
    }
  }
}
