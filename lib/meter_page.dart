import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/drawer.dart';
import 'package:segment_display/segment_display.dart';

import 'Meters/Meter.dart';

class MeterPage extends StatelessWidget {
  static String tag = 'meter-page';

  @override
  Widget build(BuildContext context) {
    final image = Expanded(
        child: Container(
      //padding: EdgeInsets.all(20),
      height: 400,
      width: MediaQuery.of(context).size.width,
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
      child: Image.network(MeterManager.getCurrentMeter().LinkIMG,
          cacheHeight: 300),
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
                    MeterManager.getCurrentMeter().TypLicznika,
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
              MeterManager.getCurrentMeter().Fazowosc,
              style: TextStyle(
                  fontSize: 25.0, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ))
    ]);
    final id = Row(children: <Widget>[
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
                    "Nr Licznika",
                    style: TextStyle(
                        fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    MeterManager.getCurrentMeter().NrLicznika,
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
              "HanPlus",
              style: TextStyle(
                  fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 10),
            if (MeterManager.getCurrentMeter().Hanplus == "T") ...[
              Text(
                "Tak",
                style: TextStyle(
                    fontSize: 25.0, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ] else ...[
              Text(
                "Nie",
                style: TextStyle(
                    fontSize: 25.0, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ]
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
                  if (MeterManager.getCurrentMeter().MeterUsedValue != "") ...[
                    SevenSegmentDisplay(
                      value: MeterManager.getCurrentMeter().MeterUsedValue,
                      size: 3.0,
                      backgroundColor: Colors.transparent,
                      segmentStyle: HexSegmentStyle(
                        disabledColor: Colors.green.withOpacity(0),
                      ),
                    ),
                  ] else ...[
                    Text(
                      "-",
                      style: TextStyle(
                          fontSize: 30.0, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ]
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
            if (MeterManager.getCurrentMeter().MeterGenerationValue != "") ...[
              SevenSegmentDisplay(
                value: MeterManager.getCurrentMeter().MeterGenerationValue,
                size: 3.0,
                backgroundColor: Colors.transparent,
                segmentStyle: HexSegmentStyle(
                  disabledColor: Colors.green.withOpacity(0),
                ),
              ),
            ] else ...[
              Text(
                "-",
                style: TextStyle(
                    fontSize: 30.0, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ]
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
          info,
          SizedBox(height: 10),
          id
        ],
      ),
    );
    return Scaffold(
      body: body,
      drawer: PublicDrawer(),
    );
  }
}
