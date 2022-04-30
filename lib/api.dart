import 'package:http/http.dart' as http;
import 'package:telicznik/utils.dart';
import 'package:xml/xml.dart';
import 'package:telicznik/login_page.dart';

class api {
  static XmlElement? TMeter;
  static String Token = "";
  static String name = "";
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

  static String DailyUsage = "";
  static String DailyGeneration = "";

  static String YeasterdayDate = "";

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
    var result = XmlDocument.parse(response.body).getElement('TMeters');
    print(result);

    TMeter = result!.getElement("TMeter");
    name = TMeter!.findElements('Description').first.text;
    City = TMeter!.findElements('City').first.text;
    Street = TMeter!.findElements('Street').first.text;
    Nr = TMeter!.findElements('Nr').first.text;
    PostalCode = TMeter!.findElements('PostalCode').first.text;
    Tarrif = TMeter!.findElements('Tarrif').first.text;

    DateFrom = TMeter!.findElements('DateFrom').first.text;
    DateTo = TMeter!.findElements('DateTo').first.text;
    MocUmowna = TMeter!.findElements('MocUmowna').first.text;
    TypLicznika = TMeter!.findElements('TypLicznika').first.text;
    NREW = TMeter!.findElements('NREW').first.text;
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
    DailyUsage = result!.text;
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
    DailyGeneration = result!.text;
    print(DailyGeneration);
  }

  static String getName() {
    return name;
  }

  static String getCity() {
    return City;
  }

  static String getStreet() {
    return Street;
  }

  static String getPostalCode() {
    return PostalCode;
  }

  static String getNr() {
    return Nr;
  }

  static String getTarrif() {
    return Tarrif;
  }

  static String getDateFrom() {
    return DateFrom;
  }

  static String getDateTo() {
    return DateTo;
  }

  static String getMocUmowna() {
    return MocUmowna;
  }

  static String getTypLicznika() {
    return TypLicznika;
  }

  static String getNREW() {
    return NREW;
  }
}
