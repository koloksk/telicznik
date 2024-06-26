import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/drawer.dart';
import 'package:segment_display/segment_display.dart';

import '../appbar.dart';

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
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 30,
            color: const Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
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
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 30,
                    color:
                        const Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Typ Licznika",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    MeterManager.getCurrentMeter().TypLicznika,
                    style: const TextStyle(fontSize: 25.0),
                  ),
                ],
              ))),
      const SizedBox(width: 10),
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
              "Fazowość",
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10),
            Text(
              MeterManager.getCurrentMeter().Fazowosc,
              style: const TextStyle(fontSize: 25.0),
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
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 30,
                    color:
                        const Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Nr Licznika",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    MeterManager.getCurrentMeter().NrLicznika,
                    style: const TextStyle(fontSize: 25.0),
                  ),
                ],
              ))),
      const SizedBox(width: 10),
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
              "HanPlus",
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10),
            if (MeterManager.getCurrentMeter().Hanplus == "T") ...[
              const Text(
                "Tak",
                style: TextStyle(fontSize: 25.0),
              ),
            ] else ...[
              const Text(
                "Nie",
                style: TextStyle(fontSize: 25.0),
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
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 30,
                    color:
                        const Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Pobór",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 10),
                  if (MeterManager.getCurrentMeter().MeterUsedValue1 != "") ...[
                    SevenSegmentDisplay(
                      value: MeterManager.getCurrentMeter().MeterUsedValue1,
                      size: 2.5,
                      backgroundColor: Colors.transparent,
                      segmentStyle: HexSegmentStyle(
                        disabledColor: Colors.green.withOpacity(0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SevenSegmentDisplay(
                      value: "-",
                      size: 2.5,
                      backgroundColor: Colors.transparent,
                      segmentStyle: HexSegmentStyle(
                        disabledColor: Colors.green.withOpacity(0),
                      ),
                    ),
                  ] else ...[
                    const Text(
                      "-",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ]
                ],
              ))),
      const SizedBox(width: 10),
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
              "Generacja",
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10),
            if (MeterManager.getCurrentMeter().MeterGenerationValue1 != "") ...[
              SevenSegmentDisplay(
                value: MeterManager.getCurrentMeter().MeterGenerationValue1,
                size: 2.5,
                backgroundColor: Colors.transparent,
                segmentStyle: HexSegmentStyle(
                  disabledColor: Colors.green.withOpacity(0),
                ),
              ),
              const SizedBox(height: 10),
              SevenSegmentDisplay(
                value: "-",
                size: 2.5,
                backgroundColor: Colors.transparent,
                segmentStyle: HexSegmentStyle(
                  disabledColor: Colors.green.withOpacity(0),
                ),
              ),
            ] else ...[
              const Text(
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
      padding: const EdgeInsets.all(25.0),
      //color: Color(0xFFFEFEFE),
      child: Column(
        children: <Widget>[
          meterStats,
          const SizedBox(height: 10),
          image,
          const SizedBox(height: 10),
          info,
          const SizedBox(height: 10),
          id
        ],
      ),
    );
    return Scaffold(
      body: body,
      drawer: PublicDrawer(),
      appBar: PublicAppBar(),
    );
  }
}
