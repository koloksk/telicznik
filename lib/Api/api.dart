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
  static String Description = "";
  static String City = "";
  static String Street = "";
  static String Nr = "";
  static String PostalCode = "";
  static String Tarrif = "";

  static String DateFrom = "";
  static String DateTo = "";
  static String MocUmowna = "";
  static String TypLicznika = "";
  static String NREW = "";
  static String LinkIMG = "";
  static String NrLicznika = "";
  static String Fazowosc = "";
  static String Hanplus = "";

  static String DailyUsage = "0";
  static String DailyGeneration = "0";

  static String YeasterdayDate = "";

  static String MeterGenerationValue = "";
  static String MeterUsedValue = "";

  static Future<bool> login(String login, String password) async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/validatev3/appslogin?username=${login}&password=${password}');
    var response = await http.post(url);
    //print(url);
    //print('Response status: ${response.statusCode}');
    print('Response : ${response.body}');
    var result = XmlDocument.parse(response.body).getElement('result');
    Token = result!.findElements('message').first.text;
    LoginPage.id = Token;
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
      Description = element.findElements('Description').first.text;
      City = element.findElements('City').first.text;
      Street = element.findElements('Street').first.text;
      Nr = element.findElements('Nr').first.text;
      MeterManager.numbers.add(Nr);

      PostalCode = element.findElements('PostalCode').first.text;
      Tarrif = element.findElements('Tarrif').first.text;

      DateFrom = element.findElements('DateFrom').first.text;
      DateTo = element.findElements('DateTo').first.text;
      MocUmowna = element.findElements('MocUmowna').first.text;
      TypLicznika = element.findElements('TypLicznika').first.text;
      NREW = element.findElements('NREW').first.text;
      LinkIMG = element.findElements('LinkIMG').first.text;
      NrLicznika = element.findElements('NrLicznika').first.text;
      Fazowosc = element.findElements('Fazowosc').first.text;
      Hanplus = element.findElements('Hanplus').first.text;
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
              MeterGenerationValue,
              MeterUsedValue));
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
    YeasterdayDate = utils.getYeasterdayDate();
    await getDailyUsage();
    await getDailyGeneration();
  }

  static getDailyUsage() async {
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
      DailyUsage = result!.text;
    }
    print(DailyUsage);
  }

  static getDailyGeneration() async {
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
      DailyGeneration = result!.text;
    } else {
      sendServerError();
    }
    print(DailyGeneration);
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

  static getMeterValues() async {
    getMeterGeneration();
    getMeterUsage();
  }

  static getMeterGeneration() async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetGLastRead?NREW=${NREW}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body)
        .getElement('RdValues')
        ?.getElement("RdValue")
        ?.getElement("Value");
    print(result);
    if (result?.text != null) {
      MeterGenerationValue = result!.text;
    } else {
      sendServerError();
      print(MeterGenerationValue);
    }
  }

  static getMeterUsage() async {
    var url = Uri.parse(
        'https://elicznik.tauron-dystrybucja.pl/webservice/v3/method/GetLastRead?NREW=${NREW}&DateTo=${YeasterdayDate}&TOKEN=${Token}');
    print(url);
    var response = await http.post(url);
    var result = XmlDocument.parse(response.body)
        .getElement('RdValues')
        ?.getElement("RdValue")
        ?.getElement("Value");
    print(result);
    if (result?.text != null) {
      MeterUsedValue = result!.text;
    } else {
      sendServerError();
    }
    print(MeterUsedValue);
  }

  static reset() {
    MeterManager.numbers.clear();
    MeterManager.meters.clear();
    Token = "";
    Description = "";
    City = "";
    Street = "";
    Nr = "";
    PostalCode = "";
    Tarrif = "";

    DateFrom = "";
    DateTo = "";
    MocUmowna = "";
    TypLicznika = "";
    NREW = "";
    LinkIMG = "";
    NrLicznika = "";
    Fazowosc = "";
    Hanplus = "";

    DailyUsage = "0";
    DailyGeneration = "0";

    YeasterdayDate = "";

    MeterGenerationValue = "";
    MeterUsedValue = "";
  }

  static String getMeterUsageValue() {
    return MeterUsedValue;
  }

  static String getMeterGenerationValue() {
    return MeterGenerationValue;
  }
}
