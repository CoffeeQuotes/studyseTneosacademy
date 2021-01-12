import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyse/network_utils/api.dart';
import 'package:studyse/screen/app_theme.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';

import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  var email;
  var password;
  var name;
  var phone;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some Code
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/bg.png"),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          )
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 25,),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Never Stop Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Form(
                        // key
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Email Address
                              Text(
                                "Please Register A New Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                              ),

                              // Full Name
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: TextFormField(
                                  style: TextStyle(color: Vx.blue600),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                    ),
                                    // prefixIcon: Icon(MaterialCommunityIcons.account, color: Colors.white,),
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(
                                      color:  Colors.white30,
                                    ),
                                    labelText: "Full Name",
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  validator: (nameValue) {
                                    if(nameValue.isEmpty) {
                                      return 'Please enter full name';
                                    }
                                    if(nameValue.length < 2) {
                                      return 'Name not long enough';
                                    }
                                    name = nameValue;
                                    return null;
                                  },
                                ),
                              ),
                              TextFormField(
                                autofocus: true,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: UnderlineInputBorder(),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white),
                                  ),
                                  // prefixIcon: Icon(MaterialCommunityIcons.mail, color: Colors.white,),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color:  Colors.white30,
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (emailValue) {
                                  if (!emailRegex.hasMatch(emailValue)) {
                                    return 'Please enter valid email';
                                  }
                                  email = emailValue;
                                  return null;
                                },
                              ),


                              // Phone
                              TextFormField(
                                style: TextStyle(color: Vx.blue600),
                                cursorColor: Vx.blue600,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white),
                                  ),
                                 // prefixIcon: Icon(MaterialCommunityIcons.phone, color: Colors.white,),
                                  hintText: "Mobile Number",
                                  hintStyle: TextStyle(
                                    color:  Colors.white30,
                                  ),
                                  labelText: "Mobile",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                  validator: (phoneValue) {
                                    if (!phoneRegex.hasMatch(phoneValue)) {
                                      return 'Please enter valid mobile numeber';
                                    }
                                    phone = phoneValue;
                                    return null;
                                  }
                              ),
                              // Password
                              TextFormField(
                                style: TextStyle(color: Vx.blue600),
                                cursorColor: Vx.blue600,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                    ),
                                  // prefixIcon: Icon(MaterialCommunityIcons.key, color: Colors.white,),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color:  Colors.white30,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  labelText: "Password"
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (passwordValue.length < 8) {
                                    return 'Your Password is too short';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 32.0),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 16,
                                        bottom: 16,
                                        left: 50,
                                        right: 50),
                                    child: Text(
                                      _isLoading ? 'Processing...' : 'Register Now',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Vx.blue800,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  color: Vx.white,
                                  disabledColor: Vx.gray800,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                       _register();
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(top: 6),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) => Login()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Already have a Account',
                                        style: TextStyle(
                                          color: Vx.white,
                                          fontSize: 16,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text('Agree With Terms of Payment & Privacy Policy', style: TextStyle(
                                  color: Colors.white,
                                ),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
  
  void _register() async {
    setState(() {
      _isLoading = true;
    });
    
    var data = {
      'email' : email,
      'password' : password, 
      'phone' : phone,
      'name' : name,
    };
    
    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);
    if(body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Home()
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
}
