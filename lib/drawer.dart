import 'package:flutter/material.dart';
import 'package:telicznik/Api/api.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/screens/charts_page.dart';
import 'package:telicznik/screens/home_page.dart';
import 'package:telicznik/screens/info_page.dart';
import 'package:telicznik/screens/login_page.dart';
import 'package:telicznik/screens/meter_page.dart';
import 'package:telicznik/screens/moc_page.dart';

class PublicDrawer extends StatefulWidget {
  @override
  _PublicDrawerState createState() => _PublicDrawerState();
}

class _PublicDrawerState extends State<PublicDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(children: <Widget>[
              Text(
                MeterManager.getCurrentMeter().Description,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                "${MeterManager.getCurrentMeter().City} ${MeterManager.getCurrentMeter().Street} ${MeterManager.getCurrentMeter().Nr}",
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              DropdownButton<String>(
                  hint: const Text("Wybierz licznik"),
                  value: MeterManager.getCurrentMeter().Nr,
                  items: MeterManager.getMeterListName().map((String value) {
                    //print(value);
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      MeterManager.currentMeter = val!;
                    });
                  }),
            ]),
          ),

          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: const Text('Dom'),
            onTap: () {
              Navigator.of(context).pushNamed(HomePage.tag);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.onetwothree,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: const Text('Licznik'),
            onTap: () {
              Navigator.of(context).pushNamed(MeterPage.tag);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.power,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: const Text('Moc'),
            onTap: () {
              Navigator.of(context).pushNamed(MocPage.tag);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.area_chart,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: const Text('Wykresy'),
            onTap: () {
              Navigator.of(context).pushNamed(ChartsPage.tag);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: const Text('Informacje'),
            onTap: () {
              Navigator.of(context).pushNamed(InfoPage.tag);
            },
          ),
          Expanded(
              child:
                  Container()), // Add this to force the bottom items to the lowest point
          Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Wyloguj'),
                onTap: () {
                  Navigator.of(context).pushNamed(LoginPage.tag);
                  api.Token = "";
                  MeterManager.reset();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
