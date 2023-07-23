import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/myapp2.dart';
import 'package:web_tut/demo_try_paginateddatatable/userdata_notifier2.dart';
import 'package:web_tut/mypage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web_tut/providers/admin_provider.dart';
import 'package:web_tut/providers/auth_provider.dart';
import 'package:web_tut/providers/college_provider.dart';
import 'package:web_tut/providers/course_provider.dart';
import 'package:web_tut/providers/has_import_provider.dart';
import 'package:web_tut/providers/otp_provider.dart';
import 'package:web_tut/providers/pie_provider.dart';
import 'package:web_tut/providers/report_provider.dart';
import 'package:web_tut/providers/request_provider.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/providers/userdata_notifier.dart';
import 'package:web_tut/screens/authentication/splash_screen.dart';
import 'package:web_tut/screens/authentication/start_page.dart';
import 'package:web_tut/utils/routes.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  // runApp(const MyApp());
  runApp(const MyApp2());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => CollegeProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => HasImportProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => UserDataNotifier()),
        // ChangeNotifierProvider(create: (_) => PieProvider()),
        StreamProvider<User>(
            create: (context) => context.read<AuthProvider>().authStateChanges,
            initialData: null),
        //---------
        ChangeNotifierProvider(create: (_) => UserDataNotifier2()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        // initialRoute: Routes.splash,
        debugShowCheckedModeBanner: false,
        title: 'UsApp Admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: Routes.routes,
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: context.watch<AuthProvider>().authStateChanges,
        builder: (_, snapshot) {
          final isSignedIn = snapshot.data != null;
          return isSignedIn ? const MyPage() : const StartPage();
        });
  }
}
