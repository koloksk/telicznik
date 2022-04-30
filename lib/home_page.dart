import 'package:flutter/material.dart';
import 'package:telicznik/api.dart';
import 'package:telicznik/drawer.dart';
import 'package:telicznik/info_page.dart';
import 'package:telicznik/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    final container = Container(
      height: 200.0,
      decoration: new BoxDecoration(
        color: Color.fromARGB(255, 231, 231, 231), //background color of box
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.pink,
            spreadRadius: 1.0, //extend the shadow
            offset: Offset(
              2.0, // Move to right 10  horizontally
              2.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: new Text("Hello world"),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[welcome, lorem, info, container],
      ),
    );

    return Scaffold(
      body: body,
      drawer: PublicDrawer(),
    );
  }
}
