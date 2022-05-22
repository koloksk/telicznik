import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:telicznik/Api/DataManager.dart';
import 'package:telicznik/Meters/Meter.dart';
import 'package:telicznik/Utils/utils.dart';
import 'package:xml/xml.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Meters/MeterManager.dart';

class api {
  static XmlElement? TMeter;

  static String Token = "";

  static String YeasterdayDate = "";

  static String MeterGenerationValue1 = "";
  static String MeterGenerationValue2 = "";
  static String MeterUsedValue1 = "";
  static String MeterUsedValue2 = "";

  static String ApiUrl =
      "https://elicznik.tauron-dystrybucja.pl/webservice/v3/method";

  static Future<bool> login(String login, String password) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/validatev3/appslogin?username=${login}&password=${password}');
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body).getElement('result');
    Token = result!.findElements('message').first.text;
    if (Token != "NO" && Token != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', Token);

      await api.getInfo();

      return true;
    } else {
      return false;
    }
  }

  static getInfo() async {
    YeasterdayDate = utils.getYeasterdayDate();

    if (await DataManager.CheckData() != false) {
      print("są dane");
      await DataManager.GetData();
      //await api.getMonthlyUsage(MeterManager.getCurrentMeter().NREW);
      //await api.getMonthlyGeneration(MeterManager.getCurrentMeter().NREW);
      //await api.getHourlyUsage(MeterManager.getCurrentMeter().NREW,
      //MeterManager.getCurrentMeter().DateFrom);
    } else {
      print("brak danych");

      var url = Uri.parse(
          'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetTokenMeterList?TOKEN=${Token}');

      var response = await http.post(url);
      var result = XmlDocument.parse(response.body).findAllElements("TMeter");
      //print(result);

      //TMeter = result?.getElement("TMeter");
      result.forEach((element) {
        String Description = element.findElements('Description').first.text;
        String City = element.findElements('City').first.text;
        String Street = element.findElements('Street').first.text;
        String Nr = element.findElements('Nr').first.text;
        //MeterManager.numbers.add(Nr);

        String PostalCode = element.findElements('PostalCode').first.text;
        String Tarrif = element.findElements('Tarrif').first.text;

        String DateFrom = element.findElements('DateFrom').first.text;
        String DateTo = element.findElements('DateTo').first.text;
        String MocUmowna = element.findElements('MocUmowna').first.text;
        String TypLicznika = element.findElements('TypLicznika').first.text;
        String NREW = element.findElements('NREW').first.text;
        String LinkIMG = element.findElements('LinkIMG').first.text;
        String NrLicznika = element.findElements('NrLicznika').first.text;
        String Fazowosc = element.findElements('Fazowosc').first.text;
        String Hanplus = element.findElements('Hanplus').first.text;
        String lastupdate = DateTime.now().toString();
        print(element);
        MeterManager.meters.putIfAbsent(
            Nr,
            () => Meter(
                Description,
                City,
                Street,
                Nr,
                PostalCode,
                Tarrif,
                DateFrom,
                DateTo,
                MocUmowna,
                TypLicznika,
                NREW,
                LinkIMG,
                NrLicznika,
                Fazowosc,
                Hanplus,
                MeterGenerationValue1,
                MeterGenerationValue2,
                MeterUsedValue1,
                MeterUsedValue2,
                lastupdate));
      });
      //MeterManager.currentMeter = MeterManager.numbers.first;
      await api.getDailyStats();
      await api.getMeterValues();
      await api.getMonthlyUsage(MeterManager.getCurrentMeter().NREW);
      await api.getMonthlyGeneration(MeterManager.getCurrentMeter().NREW);
      await api.getHourlyUsage(MeterManager.getCurrentMeter().NREW,
          MeterManager.getCurrentMeter().DateFrom);
      await api.getHourlyGeneration(MeterManager.getCurrentMeter().NREW,
          MeterManager.getCurrentMeter().DateFrom);

      await DataManager.SaveData();
    }
  }

  static getDailyStats() async {
    MeterManager.meters.forEach((key, value) async {
      String NREW = (value as Meter).NREW;
      String DateFrom = (value as Meter).DateFrom;
      //String? Mg =
      //String? Mu = await getMeterUsage(NREW);

      await getDailyUsage(NREW, DateFrom);
      await getDailyGeneration(NREW, DateFrom);
      //print("Meter usage: " + MeterManager.getMeter(value.Nr).MeterUsedValue);
    });
  }

  static getDailyUsage(String NREW, String first_date) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetReadStatD?NREW=${NREW}&DateFrom=${first_date}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body).findAllElements('Stat');
    print(result);

    result.forEach((element) {
      String day = element.getElement("Period")!.text;
      String sum = element.getElement("Sum")!.text;

      if (!MeterManager.getCurrentMeter()
          .DailyUsage
          .contains(day + ";" + sum)) {
        MeterManager.getCurrentMeter().DailyUsage.add(day + ";" + sum);
        //print(day + ";" + sum);
      }
    });
  }

  static getDailyGeneration(String NREW, String first_date) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetGStatistic?NREW=${NREW}&DateFrom=${first_date}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body).findAllElements('Stat');
    print(result);

    result.forEach((element) {
      String day = element.getElement("Period")!.text;
      String sum = element.getElement("Sum")!.text;

      if (!MeterManager.getCurrentMeter()
          .DailyGeneration
          .contains(day + ";" + sum)) {
        MeterManager.getCurrentMeter().DailyGeneration.add(day + ";" + sum);
        //print(day + ";" + sum);
      }
    });
  }

  static bool _CanShow = true;

  static sendServerError() {
    if (_CanShow == true) {
      Fluttertoast.showToast(
          msg: "Wystąpił błąd serwera. Brak niektórych danych.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      _CanShow = false;
      Timer(Duration(seconds: 10), () {
        _CanShow = true;
      });
    }
  }

  static getMeterValues() {
    MeterManager.meters.forEach((key, value) async {
      String NREW = (value as Meter).NREW;
      //String? Mg =
      //String? Mu = await getMeterUsage(NREW);
      value.MeterGenerationValue1 = await getMeterStats("GetGLastRead", NREW);
      value.MeterUsedValue1 = await getMeterStats("GetLastRead", NREW);
      //print("Meter usage: " + MeterManager.getMeter(value.Nr).MeterUsedValue);
    });
  }

  static Future<String> getMeterStats(String type, String NREW) async {
    var result;
    try {
      var url = Uri.parse(
          'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/${type}?NREW=${NREW}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
      //print(url);
      var response = await http.post(url);
      XmlDocument? xml = XmlDocument.parse(response.body);
      result = xml
          .getElement("RdValues")
          ?.getElement("RdValue")
          ?.getElement("Value");
    } catch (e) {}

    if (result?.text != null) {
      return result!.text;
    } else {
      sendServerError();
      return "";
    }
  }

  // static Future<String> getMeterUsage(String NREW) async {
  //   var url = Uri.parse(
  //       'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetLastRead?NREW=${NREW}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
  //   //print(url);
  //   var response = await http.post(url);
  //   var result = XmlDocument.parse(response.body)
  //       .getElement('RdValues')
  //       ?.getElement("RdValue")
  //       ?.getElement("Value");
  //   //print(result);
  //   //print(MeterUsedValue);
  //   if (result?.text != null) {
  //     return result!.text;
  //   } else {
  //     sendServerError();
  //     return "";
  //   }
  // }

  static getMonthlyUsage(String NREW) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetStatistic?NREW=${NREW}&DateFrom=2021-01-01&DateTo=2021-12-01&TOKEN=${Token}&Stat=M');
    //print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body).findAllElements("Stat");
    //print(result);
    //print(MeterUsedValue);
    result.forEach((element) {
      String day = element.getElement("Period")!.text.split("-")[1];
      String sum = element.getElement("Sum")!.text;
      if (!MeterManager.getCurrentMeter()
          .MonthlyUsage
          .contains(day + ";" + sum)) {
        MeterManager.getCurrentMeter().MonthlyUsage.add(day + ";" + sum);
      }
    });
    //   MeterManager.getCurrentMeter().MonthlyUsage.putIfAbsent(
    //       MeterManager.getCurrentMeter().MonthlyUsage.length + 1, () => sum);
    // });
  }

  static getMonthlyGeneration(String NREW) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetGStatistic?NREW=${NREW}&DateFrom=2021-01-01&DateTo=2021-12-01&TOKEN=${Token}&Stat=M');
    //print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body).findAllElements("Stat");
    //print(result);
    //print(MeterUsedValue);
    result.forEach((element) {
      String day = element.getElement("Period")!.text.split("-")[1];
      String sum = element.getElement("Sum")!.text;
      if (!MeterManager.getCurrentMeter()
          .MonthlyGeneration
          .contains(day + ";" + sum)) {
        MeterManager.getCurrentMeter().MonthlyGeneration.add(day + ";" + sum);
      }
    });
    //   MeterManager.getCurrentMeter().MonthlyGeneration.putIfAbsent(
    //       MeterManager.getCurrentMeter().MonthlyGeneration.length + 1,
    //       () => sum);
    // });
  }

  static getHourlyUsage(String NREW, String first_date) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetProfValue?NREW=${NREW}&DateFrom=${first_date}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body).findAllElements("PrValue");
    //print(result);
    //print(MeterUsedValue);
    result.forEach((element) {
      String day = element.getElement("Date")!.text;
      String sum = element.getElement("EC")!.text;
      String hour = element.getElement("Hour")!.text;
      if (!MeterManager.getCurrentMeter()
          .HourlyUsage
          .contains(day + ";" + hour + ";" + sum)) {
        MeterManager.getCurrentMeter()
            .HourlyUsage
            .add(day + ";" + hour + ";" + sum);
      }
    });
  }

  static getHourlyGeneration(String NREW, String first_date) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetGProfValue?NREW=${NREW}&DateFrom=${first_date}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body).findAllElements("PrValue");
    //print(result);
    //print(MeterUsedValue);
    result.forEach((element) {
      String day = element.getElement("Date")!.text;
      String sum = element.getElement("EC")!.text;
      String hour = element.getElement("Hour")!.text;
      if (!MeterManager.getCurrentMeter()
          .HourlyGeneration
          .contains(day + ";" + hour + ";" + sum)) {
        MeterManager.getCurrentMeter()
            .HourlyGeneration
            .add(day + ";" + hour + ";" + sum);
        //print(day + ";" + hour + ";" + sum);
      }
    });
  }

  static setToken(String token) async {
    Token = token;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', Token);
  }
}
