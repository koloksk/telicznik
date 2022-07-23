import 'package:flutter/material.dart';
import 'package:telicznik/Api/api.dart';

import '../Api/DataManager.dart';
import '../Meters/MeterManager.dart';
import 'home_page.dart';

class FirstLoginPage extends StatefulWidget {
  static String tag = 'firstlogin-page';

  @override
  _FirstLoginPageState createState() => new _FirstLoginPageState();
}

class _FirstLoginPageState extends State<FirstLoginPage> {
  String rawtext = "";

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print("initState");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await api.getInfo();

      setState(() {
        rawtext =
            "Znaleziono licznik (${MeterManager.getCurrentMeter().NrLicznika})";
      });
      await api.getDailyStats();
      setState(() {
        rawtext = "Pobrano dzienne statystyki ...";
      });
      await api.getMeterValues();
      setState(() {
        rawtext = "Pobrano wartości liczników ...";
      });
      await api.getMonthlyUsage(MeterManager.getCurrentMeter().NREW,
          MeterManager.getCurrentMeter().DateFrom);
      setState(() {
        rawtext = "Pobrano miesieczne zuzycie ...";
      });
      await api.getMonthlyGeneration(MeterManager.getCurrentMeter().NREW,
          MeterManager.getCurrentMeter().DateFrom);
      setState(() {
        rawtext = "Pobrano miesieczna generacje ...";
      });
      await api.getHourlyUsage(MeterManager.getCurrentMeter().NREW,
          MeterManager.getCurrentMeter().DateFrom);
      setState(() {
        rawtext = "Pobrano godzinne zuzycie ...";
      });
      await api.getHourlyGeneration(MeterManager.getCurrentMeter().NREW,
          MeterManager.getCurrentMeter().DateFrom);
      setState(() {
        rawtext = "Pobrano godzinna generacje ...";
      });
      await DataManager.SaveData();
      setState(() {
        rawtext = "Zapisano dane ...";
      });
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      await Navigator.of(context).pushNamed(HomePage.tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("firstloginpage");

    // if (api.Token == "") {
    //   Navigator.of(context).pushNamed(LoginPage.tag);
    // }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final text = Text(
      rawtext,
      textAlign: TextAlign.center,
    );

    const progress = Center(
      child: LinearProgressIndicator(),
    );

    return Scaffold(
      //backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 48.0),
            text,
            const SizedBox(height: 8.0),
            progress,
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
