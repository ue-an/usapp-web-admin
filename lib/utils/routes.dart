import 'package:flutter/material.dart';
import 'package:web_tut/main.dart';
import 'package:web_tut/mypage.dart';
import 'package:web_tut/screens/authentication/create_acct_screen.dart';
import 'package:web_tut/screens/authentication/signup_screen.dart';
import 'package:web_tut/screens/authentication/splash_screen.dart';
import 'package:web_tut/screens/dashboard.dart';
import 'package:web_tut/screens/studnumbers_screen.dart';
import 'package:web_tut/screens/view_thread_convo.dart';

class Routes {
  Routes._();

  static const String users = '/users';

  //auth
  static const String create = '/create-account';
  static const String signup = '/signup';
  static const String authWrapper = '/wrapper';
  static const String homepage = '/homepage';
  static const String loginsignup = '/login-signup';
  static const String splash = '/splash';
  static const String studentscreen = '/student-screen';
  static const String viewthread = '/view-thread-convo';

  static final routes = <String, WidgetBuilder>{
    create: (BuildContext context) => const CreateAcctScreen(),
    signup: (BuildContext context) => const SignupScreen(),
    authWrapper: (BuildContext context) => const AuthWrapper(),
    homepage: (BuildContext context) => const MyPage(),
    splash: (BuildContext context) => SplashScreen(),
    studentscreen: (context) => StudnumbersScreen(),
    viewthread: (context) => ViewThreadConvo(),
  };
}
