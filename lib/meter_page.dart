import 'package:flutter/material.dart';
import 'package:telicznik/drawer.dart';
import 'package:telicznik/home_page.dart';
import 'package:telicznik/login_page.dart';
import 'package:segment_display/segment_display.dart';
import 'package:telicznik/api.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class MeterPage extends StatelessWidget {
  static String tag = 'meter-page';
  final digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    final image = Expanded(
        child: Container(
      //padding: EdgeInsets.all(20),
      height: 400,
      //width: MediaQuery.of(context).size.width / 2 - 20,
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
      child: Image.network(api.LinkIMG),
    ));

    final info = Row(children: <Widget>[
      Expanded(
          child: Container(
              //padding: EdgeInsets.all(20),
              height: 120,
              //width: MediaQuery.of(context).size.width / 2 - 20,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Typ Licznika",
                    style: TextStyle(
                        fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    api.getTypLicznika(),
                    style: TextStyle(
                        fontSize: 25.0, color: Color.fromARGB(255, 0, 0, 0)),
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
          color: Colors.white,
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
              "Fazowość",
              style: TextStyle(
                  fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 10),
            Text(
              "3",
              style: TextStyle(
                  fontSize: 25.0, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ))
    ]);

    final meterStats = Row(children: <Widget>[
      Expanded(
          child: Container(
              //padding: EdgeInsets.all(20),
              height: 120,
              //width: MediaQuery.of(context).size.width / 2 - 20,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Pobór",
                    style: TextStyle(
                        fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 10),
                  SevenSegmentDisplay(
                    value: api.getMeterUsageValue(),
                    size: 3.0,
                    backgroundColor: Colors.transparent,
                    segmentStyle: HexSegmentStyle(
                      disabledColor: Colors.green.withOpacity(0),
                    ),
                  )
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
          color: Colors.white,
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
              "Generacja",
              style: TextStyle(
                  fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 10),
            SevenSegmentDisplay(
              value: api.getMeterGenerationValue(),
              size: 3.0,
              backgroundColor: Colors.transparent,
              segmentStyle: HexSegmentStyle(
                disabledColor: Colors.green.withOpacity(0),
              ),
            ),
          ],
        ),
      ))
    ]);
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(25.0),
      color: Color(0xFFFEFEFE),
      child: Column(
        children: <Widget>[
          meterStats,
          SizedBox(height: 10),
          image,
          SizedBox(height: 10),
          info
        ],
      ),
    );
    return Scaffold(
      body: body,
      drawer: PublicDrawer(),
    );
  }
}
