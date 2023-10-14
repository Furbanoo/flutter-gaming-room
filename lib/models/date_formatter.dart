import 'package:intl/intl.dart';

class DateFormatter {
  static String formatUnixDate(int unix) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
    String formattedDate = DateFormat("dd/MM/yyyy").format(date);
    return formattedDate;
  }
}
