import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyse/network_utils/api.dart';
import 'package:studyse/screen/register.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  var email;
  var password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some Code to undo Change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfffefefe),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/bg.png"),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Container(
                padding: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  SizedBox(height: 20,),
                  Image.asset(
                    'assets/img/logo.png',
                    height: 90.0,
                    width: 90.0,
                  ),
                  Text('Tneos',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Audiowide',
                        fontSize: 18.0,
                        letterSpacing: 2,
                      )),
                  Text('Academy',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Audiowide',
                        fontSize: 18.0,
                        letterSpacing: 2,
                      )),
                  SizedBox(height: 10,),
                  Text(
                    'Never Stop Learning',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                    ),
                  ),
                  // Expanded(
                  //   flex: 2,
                  //   child: Image.asset('assets/img/homescreen.png'),
                  // ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          child: Column(
                            children: [
                              // Email Address
                              Text(
                                "Please Login With Your Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 40),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                autofocus: true,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    // prefixIcon: Icon(MaterialCommunityIcons.mail),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Colors.white30,
                                    ),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    )),
                                keyboardType: TextInputType.emailAddress,
                                validator: (emailValue) {
                                  if (!emailRegex.hasMatch(emailValue)) {
                                    return 'Please enter valid email';
                                  }
                                  email = emailValue;
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    // prefixIcon:
                                    //     Icon(MaterialCommunityIcons.key),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Colors.white30,
                                    ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  labelText: 'Password',
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 32.0),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 16,
                                        bottom: 16,
                                        left: 20,
                                        right: 20),
                                    child: Text(
                                      _isLoading ? 'Processing...' : 'Login Now',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Vx.blue800,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  color: Colors.white,
                                  disabledColor: Vx.gray800,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _login();
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text(
                                    "Don't have an account, Sign Up!",
                                    style: TextStyle(
                                      color: Vx.white,
                                      fontSize: 16,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ])),
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': email,
      'password': password,
    };

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
