import 'dart:async';

import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/screens/firstlogin_page.dart';
import 'package:telicznik/screens/home_page.dart';
import 'package:telicznik/Api/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

//BLOKADA PRZYCISKOW
//ZMIANA KONTENERA STATYSTYK W HOME ZEBY SIE NIE RUSZAL

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late bool _isButtonDisabled;

  // @override
  // void initState() {
  //   _isButtonDisabled = false;
  // }
  bool loginbuttonenabled = true;
  _launchURL() async {
    const url = 'https://logowanie.tauron-dystrybucja.pl/remind_password';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<bool> autoLogIn(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedtoken = prefs.getString('token');
    if (savedtoken != null && savedtoken != "") {
      //print("Zapisany token: " + savedtoken);
      api.Token = savedtoken;

      await api.getInfo();
      //Navigator.of(context).pushNamed(FirstLoginPage.tag);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    autoLogIn(context);

    final TextEditingController loginController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      controller: loginController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      autovalidateMode: AutovalidateMode.always,
      //initialValue: 'alucard@gmail.com',
      //maxLength: 30,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      autofocus: false,
      //initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Hasło',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () async {
            if (loginbuttonenabled) {
              loginbuttonenabled = false;
              EasyLoading.show();
              String? token = await api.login(
                  loginController.text, passwordController.text);
              if (token != null) {
                EasyLoading.dismiss();

                if (!mounted) return;
                Navigator.of(context).pushNamed(FirstLoginPage.tag);
              } else {
                EasyLoading.dismiss();

                Fluttertoast.showToast(
                    msg: "Login lub hasło jest nieprawidłowe",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }

              Timer(const Duration(seconds: 5), () {
                loginbuttonenabled = true;
              });
            }
          },
          color: Colors.lightBlueAccent,
          child:
              const Text('Zaloguj się', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = TextButton(
      onPressed: _launchURL,
      child: const Text(
        'Nie pamiętasz hasła?',
        //style: TextStyle(color: Colors.black54),
      ),
    );
    final demo = TextButton(
      child: const Text(
        'Przetestuj demo',
        //style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        api.Token = "GMO1JKRII20EPQ725RBCR5J9YU3UZZDE";

        EasyLoading.dismiss();
        Navigator.of(context).pushNamed(FirstLoginPage.tag);
      },
    );
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 48.0),
            email,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            forgotLabel,
            demo
          ],
        ),
      ),
    );
  }
}
