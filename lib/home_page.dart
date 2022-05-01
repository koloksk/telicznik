import 'package:flutter/material.dart';
import 'package:telicznik/api.dart';
import 'package:telicznik/drawer.dart';
import 'package:telicznik/info_page.dart';
import 'package:telicznik/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  // if (LoginPage.id != "NO" && LoginPage.id != null) {
  //   print(LoginPage.id);
  //   Navigator.of(context).pushNamed(HomePage.tag);
  // }

  @override
  Widget build(BuildContext context) {
    if (LoginPage.id == null) {
      Navigator.of(context).pushNamed(LoginPage.tag);
    }

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        api.getName(),
        style: TextStyle(fontSize: 28.0, color: Colors.black),
      ),
    );

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
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              )
            ]));
    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        api.getCity() + " " + api.getStreet() + " " + api.getPostalCode(),
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );
    final info = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Dzienne zurzycie: " + api.DailyUsage + "/" + api.DailyGeneration,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

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
