import 'package:flutter/material.dart';
import 'package:telicznik/Api/api.dart';
import 'package:telicznik/charts/chart.dart';
import 'package:telicznik/drawer.dart';
import 'package:telicznik/login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        // Enables the trackball
        enable: true,
        tooltipSettings: InteractiveTooltip(enable: true, color: Colors.red));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (api.Token == null) {
      Navigator.of(context).pushNamed(LoginPage.tag);
    }

    final card1 = Container(
        //padding: EdgeInsets.all(20),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
            ),
          ],
        ),
        child: GridView(
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
                    double.parse(api.DailyGeneration.toString())
                            .toStringAsFixed(1) +
                        "kWh",
                    style: TextStyle(fontSize: 13.0, color: Colors.black),
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
                    double.parse(api.DailyUsage.toString()).toStringAsFixed(1) +
                        "kWh",
                    style: TextStyle(fontSize: 13.0, color: Colors.black),
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
    final chart = Container(
        //padding: EdgeInsets.all(20),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
            ),
          ],
        ),
        child: PointsLineChart.withSampleData());

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(23.0),
      color: Color(0xFFFEFEFE),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          card1,
          SizedBox(height: 10),
          chart
        ],
      ),
    );

    return Scaffold(
      body: body,
      drawer: PublicDrawer(),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class SalesData1 {
  SalesData1(this.year1, this.sales1);
  final String year1;
  final double sales1;
}
