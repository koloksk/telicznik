import 'package:telicznik/Api/api.dart';

import 'Meter.dart';
import 'package:telicznik/Api/api.dart';

class MeterManager {
  static Map meters = new Map();
  static List<String> numbers = <String>[];
  static String currentMeter = "";

  static Meter getMeter(String name) {
    return meters[name];
  }

  static Meter getCurrentMeter() {
    return meters[currentMeter];
  }
}
