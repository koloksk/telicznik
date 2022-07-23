import 'package:flutter/material.dart';
import 'package:telicznik/Api/api.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/appbar.dart';
import 'package:telicznik/charts/chart_template.dart';
import 'package:telicznik/charts/charts_data.dart';
//import 'package:telicznik/charts/chart.dart';
import 'package:telicznik/drawer.dart';
import 'package:telicznik/screens/login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    print("homepage");

    final card1 = Container(
        //padding: EdgeInsets.all(20),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 30,
              color: const Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
            ),
          ],
        ),
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          children: [
            const Icon(
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
                  const Icon(FontAwesomeIcons.arrowRightLong, size: 40.0),
                  Text(
                    "${double.parse(MeterManager.getCurrentMeter().DailyGeneration.last.toString().split(";")[1]).toStringAsFixed(1)}kWh",
                    style: const TextStyle(fontSize: 13.0),
                  ),
                ],
              ),
            ),
            const Icon(
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
                  const Icon(FontAwesomeIcons.arrowRightLong, size: 40.0),
                  Text(
                    "${double.parse(MeterManager.getCurrentMeter().DailyUsage.last.toString().split(";")[1]).toStringAsFixed(1)}kWh",
                    style: const TextStyle(fontSize: 13.0),
                  ),
                ],
              ),
            ),
            const Icon(
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
              offset: const Offset(0, 4),
              blurRadius: 30,
              color: const Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Ostatnia aktualizacja",
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10),
            Text(
              MeterManager.getCurrentMeter().lastupdate,
              style: const TextStyle(fontSize: 25.0),
            ),
          ],
        ));
    final test = Container(
        //padding: EdgeInsets.all(20),
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 30,
              color: const Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Aktualny miesiąc",
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10),
            Text(
              "${MeterManager.getCurrentMeter().MonthlyGeneration.last.split(';')[2]} + ${MeterManager.getCurrentMeter().MonthlyUsage.last.split(';')[2]}",
              style: const TextStyle(fontSize: 25.0),
            ),
          ],
        ));
    final body = Column(
      children: <Widget>[
        const SizedBox(height: 10),
        card1,
        const SizedBox(height: 10),
        chart_template(
            datausage: createMonthlyUsage("${DateTime.now().year}"),
            datageneration: createMonthlyGeneration("${DateTime.now().year}")),
        const SizedBox(height: 10),
        lastupdate,
        test
      ],
    );

    return Scaffold(
      body: SingleChildScrollView(child: body),
      drawer: PublicDrawer(),
      appBar: PublicAppBar(),
    );
  }
}
