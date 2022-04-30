import 'package:intl/intl.dart';

class utils {
  static String getYeasterdayDate() {
    DateTime now = DateTime.now().subtract(const Duration(days: 1));
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    //print(formattedDate);
    return (formattedDate);
  }
}
