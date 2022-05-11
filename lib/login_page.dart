import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/home_page.dart';
import 'package:telicznik/Api/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late bool _isButtonDisabled;

  // @override
  // void initState() {
  //   _isButtonDisabled = false;
  // }

  _launchURL() async {
    const url = 'https://logowanie.tauron-dystrybucja.pl/remind_password';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String? token = null;

  @override
  Widget build(BuildContext context) {
    final TextEditingController loginController = new TextEditingController();
    final TextEditingController passwordController =
        new TextEditingController();
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
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () async {
            ///TODO: Włączanie i wyłączanie przycisku po wciśnięciu
            Fluttertoast.cancel(); //Chwilowe rozwiązanie spamiących komunikatów
            EasyLoading.show();
            MeterManager.reset();
            bool token =
                await api.login(loginController.text, passwordController.text);
            if (token == true) {
              try {
                await api.getInfo();
                await api.getDailyStats();
                await api.getMeterValues();
                await api.getMonthlyUsage(MeterManager.getCurrentMeter().NREW);
                EasyLoading.dismiss();
                Navigator.of(context).pushNamed(HomePage.tag);
              } catch (e) {
                log(e.toString());
              }
            } else {
              try {
                EasyLoading.dismiss();
                Fluttertoast.showToast(
                    msg: "Login lub hasło jest nieprawidłowe",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } catch (e) {
                log(e.toString());
              }
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Zaloguj się', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = TextButton(
      child: Text(
        'Nie pamiętasz hasła?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: _launchURL,
    );
    final demo = TextButton(
      child: Text(
        'Przetestuj demo',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () async {
        api.setToken("GMO1JKRII20EPQ725RBCR5J9YU3UZZDE");
        //LoginPage.id = api.Token;

        await api.getInfo();
        await api.getDailyStats();
        await api.getMeterValues();
        await api.getMonthlyUsage(MeterManager.getCurrentMeter().NREW);
        EasyLoading.dismiss();
        Navigator.of(context).pushNamed(HomePage.tag);
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel,
            demo
          ],
        ),
      ),
    );
  }
}
