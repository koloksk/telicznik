import 'package:flutter/material.dart';
import 'package:telicznik/info_page.dart';
import 'package:telicznik/meter_page.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'info_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    InfoPage.tag: (context) => InfoPage(),
    MeterPage.tag: (context) => MeterPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telicznik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
      builder: EasyLoading.init(),
    );
  }
}
