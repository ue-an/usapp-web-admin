import 'dart:js';

import 'package:flutter/material.dart';
import 'package:web_tut/2.0/screens/admin_profile/admin_profile.dart';
import 'package:web_tut/screens/authentication/splash_screen.dart';
import 'package:web_tut/screens/view_archive_threads.dart';
import 'package:web_tut/screens/view_thread_convo.dart';

class Routes2 {
  Routes2._();

  static const String users = '/users';
  //auth
  //
  static const String dashboard = '/dashboard';
  static const String splash = '/splash';
  static const String viewforum = '/view-forum-convo';
  static const String viewarchiveforum = '/view-archive-forum';
  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    viewforum: (context) => const ViewThreadConvo(),
    viewarchiveforum: (context) => const ViewArchiveThreadConvo(),
  };
}
