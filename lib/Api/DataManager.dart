import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Meters/Meter.dart';
import '../Meters/MeterManager.dart';

class DataManager {
  static Future<bool> CheckData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Meters = prefs.getString('meters');

    if (Meters != null && Meters != "") {
      return true;
    } else {
      return false;
    }
  }

  static GetData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Meters = prefs.getString('meters');
    print(json.decode(Meters!));
    print(Meters);
    Map jsonmap = json.decode(Meters);
    jsonmap.forEach((key, value) {
      MeterManager.meters
          .putIfAbsent(key, () => new Meter.fromJson(json.decode(Meters)[key]));
    });
  }

  static SaveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(json.encode(MeterManager.meters));
    prefs.setString('meters', json.encode(MeterManager.meters));
  }

  static ResetData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('meters', "");
    prefs.setString('token', "");
  }
}
