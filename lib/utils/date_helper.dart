import 'package:intl/intl.dart';

class DateHelper {
  static DateTime timeStampToDateTime(int timeStamp ) {
    // Convert the timestamp (in seconds) to DateTime by multiplying by 1000
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    return date;
  }
  static String dateOnly(int timeStamp ) {
   var date= timeStampToDateTime( timeStamp );
    return DateFormat('d MMM yyyy').format(date); // 21 Feb 2024
  }
}
