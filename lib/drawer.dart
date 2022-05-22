import 'dart:math';

import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/screens/charts_page.dart';
import 'package:telicznik/screens/home_page.dart';
import 'package:telicznik/screens/info_page.dart';
import 'package:telicznik/screens/login_page.dart';
import 'package:telicznik/screens/meter_page.dart';
import 'package:telicznik/screens/moc_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                MeterManager.getCurrentMeter().City +
                    " " +
                    MeterManager.getCurrentMeter().Street +
                    " " +
                    MeterManager.getCurrentMeter().Nr,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              DropdownButton<String>(
                  hint: Text("Wybierz licznik"),
                  value: MeterManager.getCurrentMeter().Nr,
                  items: MeterManager.getMeterListName().map((String value) {
                    print(value);
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
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
            leading: Icon(
              Icons.home,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: Text('Dom'),
            onTap: () {
              Navigator.of(context).pushNamed(HomePage.tag);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.onetwothree,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: Text('Licznik'),
            onTap: () {
              Navigator.of(context).pushNamed(MeterPage.tag);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.power,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: Text('Moc'),
            onTap: () {
              Navigator.of(context).pushNamed(MocPage.tag);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.area_chart,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: Text('Wykresy'),
            onTap: () {
              Navigator.of(context).pushNamed(ChartsPage.tag);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: Text('Informacje'),
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
                leading: Icon(Icons.logout),
                title: Text('Wyloguj'),
                onTap: () async {
                  MeterManager.reset();
                  Navigator.of(context).pushNamed(LoginPage.tag);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
