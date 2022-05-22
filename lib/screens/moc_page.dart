import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/drawer.dart';
import 'package:segment_display/segment_display.dart';

class MocPage extends StatelessWidget {
  static String tag = 'moc-page';

  @override
  Widget build(BuildContext context) {
    final info = Row(children: <Widget>[
      Expanded(
          child: Container(
              //padding: EdgeInsets.all(20),
              height: 120,
              //width: MediaQuery.of(context).size.width / 2 - 20,
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
                    "Moc Umowna",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    MeterManager.getCurrentMeter().MocUmowna + " KW",
                    style: TextStyle(fontSize: 25.0),
                  ),
                ],
              ))),
      SizedBox(width: 10),
      Expanded(
          child: Container(
        //padding: EdgeInsets.all(20),
        height: 120,
        //width: body.size.width / 2 - 20,
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
              "MAX w tym tyg.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            Text(
              "-",
              style: TextStyle(fontSize: 25.0),
            ),
          ],
        ),
      ))
    ]);

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(25.0),
      //color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          info,
        ],
      ),
    );
    return Scaffold(
      body: body,
      drawer: PublicDrawer(),
    );
  }
}
