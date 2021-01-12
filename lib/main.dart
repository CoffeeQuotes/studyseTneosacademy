import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyse/screen/app_theme.dart';
import 'package:studyse/screen/home.dart';
import 'package:studyse/screen/login.dart';
import 'package:studyse/screen/register.dart';
import 'package:flutter/services.dart';
import "package:velocity_x/velocity_x.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Tneos Academy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Vx.gray900,
        textTheme: AppTheme.textTheme,
        fontFamily: 'Montserrat',
        platform: TargetPlatform.android,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CheckAuth(),
    );
  }
}
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if(isAuth) {
      child = Home();
    } else {
      child = Login();
    }
    return Scaffold(
      body: child,
    );
  }
}

