import 'package:flutter/material.dart';
import 'package:telicznik/home_page.dart';
import 'package:telicznik/Api/api.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  static var id = null;
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            EasyLoading.show();
            api.reset();
            bool token =
                await api.login(loginController.text, passwordController.text);
            if (token == true) {
              await api.getInfo();
              await api.getDailyStats();
              await api.getMeterValues();
              EasyLoading.dismiss();
              Navigator.of(context).pushNamed(HomePage.tag);
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

            // var url = Uri.parse(
            //     'https://elicznik.tauron-dystrybucja.pl/validatev3/appslogin?username=' +
            //         loginController.text +
            //         "&password=" +
            //         passwordController.text);
            // var response = await http.post(url);
            // //print(url);
            // //print('Response status: ${response.statusCode}');
            // //print('Response : ${response.body}');
            // var result = XmlDocument.parse(response.body).getElement('result');
            // LoginPage.id = result!.findElements('message').first.text;
            // if (LoginPage.id != "NO" && LoginPage.id != null) {
            //   print(LoginPage.id);

            //   final prefs = await SharedPreferences.getInstance();
            //   await prefs.setString('token', LoginPage.id);

            //   EasyLoading.dismiss();
            //   Navigator.of(context).pushNamed(HomePage.tag);
            // } else {

            // }
          },
          color: Colors.lightBlueAccent,
          child: Text('Zaloguj się', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Nie pamiętasz hasła?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: _launchURL,
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
            forgotLabel
          ],
        ),
      ),
    );
  }
}
