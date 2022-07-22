import 'package:flutter/material.dart';
import 'package:telicznik/Api/api.dart';
import 'package:telicznik/Meters/MeterManager.dart';
//import 'package:telicznik/charts/chart.dart';
import 'package:telicznik/drawer.dart';
import 'package:telicznik/screens/login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../charts/monthly_chart.dart';

class HomePage extends StatefulWidget {
  /// Creates the stacked line chart sample.
  static String tag = 'home-page';

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  // if (LoginPage.id != "NO" && LoginPage.id != null) {
  //   print(LoginPage.id);
  //   Navigator.of(context).pushNamed(HomePage.tag);
  // }

  @override
  Widget build(BuildContext context) {
    if (api.Token == "") {
      Navigator.of(context).pushNamed(LoginPage.tag);
    }

    final card1 = Container(
        //padding: EdgeInsets.all(20),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
            ),
          ],
        ),
        child: GridView(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          children: [
            Icon(
              FontAwesomeIcons.solarPanel,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Wrap(
                spacing: 80.0, // gap between adjacent chips
                runSpacing: 4.0,
                alignment: WrapAlignment.center,
                direction: Axis.horizontal, // ma
                children: <Widget>[
                  Icon(FontAwesomeIcons.arrowRightLong, size: 40.0),
                  Text(
                    double.parse(MeterManager.getCurrentMeter()
                                .DailyGeneration
                                .last
                                .toString()
                                .split(";")[1])
                            .toStringAsFixed(1) +
                        "kWh",
                    style: TextStyle(fontSize: 13.0),
                  ),
                ],
              ),
            ),
            Icon(
              FontAwesomeIcons.bolt,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Wrap(
                spacing: 80.0, // gap between adjacent chips
                runSpacing: 4.0,
                alignment: WrapAlignment.center,
                direction: Axis.horizontal, // ma
                children: <Widget>[
                  Icon(FontAwesomeIcons.arrowRightLong, size: 40.0),
                  Text(
                    double.parse(MeterManager.getCurrentMeter()
                                .DailyUsage
                                .last
                                .toString()
                                .split(";")[1])
                            .toStringAsFixed(1) +
                        "kWh",
                    style: TextStyle(fontSize: 13.0),
                  ),
                ],
              ),
            ),
            Icon(
              FontAwesomeIcons.house,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
          ],
        ));
    // final chart = Container(
    //     //padding: EdgeInsets.all(20),
    //     height: 200,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20),
    //       color: Colors.white,
    //       boxShadow: [
    //         BoxShadow(
    //           offset: Offset(0, 4),
    //           blurRadius: 30,
    //           color: Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
    //         ),
    //       ],
    //     ),
    //     child: PointsLineChart.withSampleData());
    final lastupdate = Container(
        //padding: EdgeInsets.all(20),
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ostatnia aktualizacja",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            Text(
              MeterManager.getCurrentMeter().lastupdate,
              style: TextStyle(fontSize: 25.0),
            ),
          ],
        ));

    final body = Column(
      children: <Widget>[
        SizedBox(height: 10),
        card1,
        SizedBox(height: 10),
        LineChartWidget(),
        SizedBox(height: 10),
        lastupdate
      ],
    );

    return Scaffold(
      body: SingleChildScrollView(child: body),
      drawer: PublicDrawer(),
    );
  }
}
