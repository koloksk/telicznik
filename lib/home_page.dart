import 'package:flutter/material.dart';
import 'package:telicznik/Api/api.dart';
import 'package:telicznik/drawer.dart';
import 'package:telicznik/info_page.dart';
import 'package:telicznik/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    if (LoginPage.id == null) {
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
        child: SfCartesianChart(
            // Initialize category axis
            trackballBehavior: _trackballBehavior,
            primaryXAxis: CategoryAxis(),
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                // Bind data source
                dataSource: <SalesData>[
                  SalesData('1', 35),
                  SalesData('2', 28),
                  SalesData('3', 34),
                  SalesData('4', 32),
                  SalesData('5', 40),
                  SalesData('6', 35),
                  SalesData('7', 28),
                  SalesData('8', 34),
                  SalesData('9', 32),
                  SalesData('10', 40),
                  SalesData('11', 35),
                  SalesData('12', 28),
                  SalesData('13', 34),
                  SalesData('14', 32),
                  SalesData('15', 40),
                  SalesData('16', 35),
                  SalesData('17', 28),
                  SalesData('18', 34),
                  SalesData('19', 32),
                  SalesData('20', 40),
                  SalesData('21', 40),
                  SalesData('22', 35),
                  SalesData('23', 28),
                  SalesData('24', 34),
                  SalesData('25', 32),
                  SalesData('26', 40),
                  SalesData('27', 35),
                  SalesData('28', 28),
                  SalesData('29', 34),
                  SalesData('30', 32),
                  SalesData('31', 40)
                ],
                name: 'Generacja',
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                dataLabelSettings: DataLabelSettings(isVisible: false),
              ),
              LineSeries<SalesData, String>(
                // Bind data source
                dataSource: <SalesData>[
                  SalesData('1', 2),
                  SalesData('2', 34),
                  SalesData('3', 12),
                  SalesData('4', 345),
                  SalesData('5', 34),
                  SalesData('6', 1),
                  SalesData('7', 32),
                  SalesData('8', 34),
                  SalesData('9', 5),
                  SalesData('10', 123),
                  SalesData('11', 1),
                  SalesData('12', 23),
                  SalesData('13', 3),
                  SalesData('14', 34),
                  SalesData('15', 12),
                  SalesData('16', 4),
                  SalesData('17', 46),
                  SalesData('18', 7),
                  SalesData('19', 2),
                  SalesData('20', 4),
                  SalesData('21', 56),
                  SalesData('22', 23),
                  SalesData('23', 58),
                  SalesData('24', 2),
                  SalesData('25', 54),
                  SalesData('26', 6),
                  SalesData('27', 2),
                  SalesData('28', 63),
                  SalesData('29', 23),
                  SalesData('30', 54),
                  SalesData('31', 11)
                ],
                name: 'Pobór',
                xValueMapper: (SalesData sales1, _) => sales1.year,
                yValueMapper: (SalesData sales1, _) => sales1.sales,
                dataLabelSettings: DataLabelSettings(isVisible: false),
              )
            ]));

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
