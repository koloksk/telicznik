import 'package:flutter/material.dart';
import 'package:telicznik/api.dart';
import 'package:telicznik/home_page.dart';
import 'package:telicznik/info_page.dart';
import 'package:telicznik/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

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
                api.name,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                api.getCity() + " " + api.getStreet() + " " + api.getNr(),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
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
              Icons.account_circle,
              color: Color.fromARGB(255, 226, 0, 112),
            ),
            title: Text('Profile'),
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
                onTap: () {
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
