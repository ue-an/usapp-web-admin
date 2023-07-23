import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_tut/2.0/screens/main/main_screen.dart';
import 'package:web_tut/mypage.dart';
import 'package:web_tut/screens/authentication/start_page.dart';

class SplashScreen extends StatefulWidget {
  // static const String splashRoute = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var userStatus;
  Future checkUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userStatus = prefs.getString('userstatus');
      print("==On Load Check ==");
      // print(widget.value);
      print(userStatus);
    });
  }

  @override
  void initState() {
    super.initState();

    //Call check for landing page in init state of your home page widget
    checkUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;
    return userStatus == null ? const StartPage() : MainScreen();
  }
}
