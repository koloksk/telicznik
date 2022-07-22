import 'package:flutter/material.dart';
import 'package:telicznik/drawer.dart';

import '../appbar.dart';

class InfoPage extends StatelessWidget {
  static String tag = 'info-page';

  @override
  Widget build(BuildContext context) {
    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "hello",
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(28.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[lorem],
      ),
    );
    return Scaffold(
      body: body,
      drawer: PublicDrawer(),
      appBar: PublicAppBar(),
    );
  }
}
