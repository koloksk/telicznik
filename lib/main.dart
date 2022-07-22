import 'package:flutter/material.dart';
import 'package:telicznik/screens/charts_page.dart';
import 'package:telicznik/screens/info_page.dart';
import 'package:telicznik/screens/meter_page.dart';
import 'package:telicznik/screens/moc_page.dart';
import 'package:telicznik/screens/firstlogin_page.dart';

import 'package:telicznik/themes.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/info_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telicznik/Api/api.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:month_year_picker/month_year_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Widget _defaultHome = LoginPage();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedtoken = prefs.getString('token');

  // Get result of the login function.
  if (savedtoken != null && savedtoken != "") {
    LoadingFlipping.circle();

    api.Token = savedtoken;
    await api.getInfo();
    _defaultHome = HomePage();
  }

  runApp(MyApp(_defaultHome));
}

class MyApp extends StatelessWidget {
  MyApp(Widget? defaultHome) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    this.defaultHome = defaultHome;
  }

  late Widget? defaultHome;

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    InfoPage.tag: (context) => InfoPage(),
    MeterPage.tag: (context) => MeterPage(),
    MocPage.tag: (context) => MocPage(),
    ChartsPage.tag: (context) => ChartsPage(),
    FirstLoginPage.tag: (context) => FirstLoginPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telicznik',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: Themes.lighttheme,
      darkTheme: Themes.darktheme,
      home: defaultHome,
      routes: routes,
      builder: EasyLoading.init(),
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}
