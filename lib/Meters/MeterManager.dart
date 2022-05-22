import 'package:telicznik/Api/DataManager.dart';

import 'Meter.dart';

class MeterManager {
  static Map meters = new Map();
  //static List<String> numbers = <String>[];
  static String currentMeter = "";

  static Meter getMeter(String name) {
    return meters[name];
  }

  static Meter getCurrentMeter() {
    print(meters.keys);
    if (currentMeter == "") {
      List<String> numbers = <String>[];

      meters.forEach((key, value) {
        numbers.add(key.toString());
      });
      return meters[numbers.first];
    } else {
      return meters[currentMeter];
    }
  }

  static List<String> getMeterListName() {
    List<String> numbers = <String>[];

    meters.forEach((key, value) {
      numbers.add(key.toString());
    });
    print("numbers: " + numbers.toString());
    return numbers;
  }

  static reset() {
    meters.clear();
    //numbers.clear();
    currentMeter = "";
    DataManager.ResetData();
  }
}
