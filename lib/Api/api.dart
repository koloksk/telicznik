import 'package:http/http.dart' as http;
import 'package:telicznik/Meters/Meter.dart';
import 'package:telicznik/Utils/utils.dart';
import 'package:xml/xml.dart';
import 'package:telicznik/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../Meters/MeterManager.dart';

class api {
  //static Map meters = new Map();
  //static List<String> numbers = <String>[];
  static XmlElement? TMeter;

  static String Token = "";
  // static String Description = "";
  // static String City = "";
  // static String Street = "";
  // static String Nr = "";
  // static String PostalCode = "";
  // static String Tarrif = "";

  // static String DateFrom = "";
  // static String DateTo = "";
  // static String MocUmowna = "";
  // static String TypLicznika = "";
  // static String NREW = "";
  // static String LinkIMG = "";
  // static String NrLicznika = "";
  // static String Fazowosc = "";
  // static String Hanplus = "";

  static String DailyUsage = "0";
  static String DailyGeneration = "0";

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
    //print(url);
    //print('Response status: ${response.statusCode}');
    print('Response : ${response.body}');
    var result = XmlDocument.parse(response.body).getElement('result');
    Token = result!.findElements('message').first.text;
    if (Token != "NO" && Token != null) {
      print("true");

      return true;
    } else {
      return false;
    }
  }

  static getInfo() async {
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
      MeterManager.numbers.add(Nr);

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
              DailyUsage,
              DailyGeneration,
              MeterGenerationValue1,
              MeterGenerationValue2,
              MeterUsedValue1,
              MeterUsedValue2));
    });
    MeterManager.currentMeter = MeterManager.numbers.first;
    //print((meters["1"] as Meter).Description);

    // Description = TMeter!.findElements('Description').first.text;
    // City = TMeter!.findElements('City').first.text;
    // Street = TMeter!.findElements('Street').first.text;
    // Nr = TMeter!.findElements('Nr').first.text;
    // PostalCode = TMeter!.findElements('PostalCode').first.text;
    // Tarrif = TMeter!.findElements('Tarrif').first.text;

    // DateFrom = TMeter!.findElements('DateFrom').first.text;
    // DateTo = TMeter!.findElements('DateTo').first.text;
    // MocUmowna = TMeter!.findElements('MocUmowna').first.text;
    // TypLicznika = TMeter!.findElements('TypLicznika').first.text;
    // NREW = TMeter!.findElements('NREW').first.text;
    // LinkIMG = TMeter!.findElements('LinkIMG').first.text;
    // NrLicznika = TMeter!.findElements('NrLicznika').first.text;
    // Fazowosc = TMeter!.findElements('Fazowosc').first.text;
    // Hanplus = TMeter!.findElements('Hanplus').first.text;
  }

  static getDailyStats() async {
    try {
      YeasterdayDate = utils.getYeasterdayDate();

      MeterManager.meters.forEach((key, value) async {
        String NREW = (value as Meter).NREW;
        //String? Mg =
        //String? Mu = await getMeterUsage(NREW);
        value.MeterGenerationValue1 = await getDailyGeneration(NREW);
        value.MeterUsedValue1 = await getDailyUsage(NREW);
        //print("Meter usage: " + MeterManager.getMeter(value.Nr).MeterUsedValue);
      });
    } catch (e) {}
  }

  static Future<String> getDailyUsage(String NREW) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetReadStatD?NREW=${NREW}&DateFrom=${YeasterdayDate}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body)
        .getElement('Stats')
        ?.getElement("Stat")
        ?.getElement("Sum");
    print(result);

    if (result?.text != null) {
      return result!.text;
    } else {
      sendServerError();
      return "0";
    }
  }

  static Future<String> getDailyGeneration(String NREW) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetGStatistic?NREW=${NREW}&DateFrom=${YeasterdayDate}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body)
        .getElement('Stats')
        ?.getElement("Stat")
        ?.getElement("Sum");
    print(result);
    if (result?.text != null) {
      return result!.text;
    } else {
      sendServerError();
      return "0";
    }
  }

  static sendServerError() {
    Fluttertoast.showToast(
        msg: "Wystąpił błąd serwera. Brak niektórych danych.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static getMeterValues() {
    MeterManager.meters.forEach((key, value) async {
      String NREW = (value as Meter).NREW;
      //String? Mg =
      //String? Mu = await getMeterUsage(NREW);
      value.MeterGenerationValue1 = await getMeterGeneration(NREW);
      value.MeterUsedValue1 = await getMeterUsage(NREW);
      //print("Meter usage: " + MeterManager.getMeter(value.Nr).MeterUsedValue);
    });
  }

  static Future<String> getMeterGeneration(String NREW) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetGLastRead?NREW=${NREW}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    //print(url);
    var response = await http.post(url);
    XmlDocument? xml = XmlDocument.parse(response.body);
    var result =
        xml.getElement("RdValues")?.getElement("RdValue")?.getElement("Value");
    if (result?.text != null) {
      return result!.text;
    } else {
      sendServerError();
      return "";
    }
  }

  static Future<String> getMeterUsage(String NREW) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetLastRead?NREW=${NREW}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    //print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body)
        .getElement('RdValues')
        ?.getElement("RdValue")
        ?.getElement("Value");
    //print(result);
    //print(MeterUsedValue);
    if (result?.text != null) {
      return result!.text;
    } else {
      sendServerError();
      return "";
    }
  }

  static getMonthlyUsage(String NREW) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetStatistic?NREW=${NREW}&DateFrom=2022-01-01&DateTo=2022-12-01&TOKEN=${Token}&Stat=M');
    //print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body).findAllElements("Stat");
    //print(result);
    //print(MeterUsedValue);
    result.forEach((element) {
      String day = element.getElement("Period")!.text;
      String sum = element.getElement("Sum")!.text;

      MeterManager.getCurrentMeter().MonthlyUsage.putIfAbsent(
          MeterManager.getCurrentMeter().MonthlyUsage.length + 1, () => sum);
    });
  }

  static setToken(String token) {
    Token = token;
  }
  // static reset() {
  //   MeterManager.numbers.clear();
  //   MeterManager.meters.clear();
  //   Token = "";
  //   Description = "";
  //   City = "";
  //   Street = "";
  //   Nr = "";
  //   PostalCode = "";
  //   Tarrif = "";

  //   DateFrom = "";
  //   DateTo = "";
  //   MocUmowna = "";
  //   TypLicznika = "";
  //   //NREW = "";
  //   LinkIMG = "";
  //   NrLicznika = "";
  //   Fazowosc = "";
  //   Hanplus = "";

  //   DailyUsage = "0";
  //   DailyGeneration = "0";

  //   YeasterdayDate = "";

  //   MeterGenerationValue1 = "";
  //   MeterUsedValue1 = "";
  // }
}
