import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/drawerpage_provider.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/adminactivities_search_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/logtype_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/useractivity_search_provider.dart';
import 'package:web_tut/2.0/screens/administrators_list/components/selection_adminslist_provider.dart';
import 'package:web_tut/2.0/screens/colleges/components/selection_college_provider.dart';
import 'package:web_tut/2.0/screens/main/main_screen.dart';
import 'package:web_tut/2.0/screens/courses/components/selection_course_provider.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/selection_archived_forums_provider.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/selection_reportedforums_provider.dart';
import 'package:web_tut/2.0/screens/students/components/selection_provider.dart';
import 'package:web_tut/2.0/screens/students/components/sfdata_search_provider.dart';
import 'package:web_tut/2.0/screens/thread_reply/thread_reply_provider.dart';
import 'package:web_tut/2.0/screens/update_details_request/components/selection_request.dart';
import 'package:web_tut/2.0/utils/routes2.dart';
import 'package:web_tut/demo_try_paginateddatatable/userdata_notifier2.dart';
import 'package:web_tut/providers/actlog_daterange_provider.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/admin_provider.dart';
import 'package:web_tut/providers/archive_report_provider.dart';
import 'package:web_tut/providers/auth_provider.dart';
import 'package:web_tut/providers/ay_dates_provider.dart';
import 'package:web_tut/providers/college_provider.dart';
import 'package:web_tut/providers/course_provider.dart';
import 'package:web_tut/providers/has_import_provider.dart';
import 'package:web_tut/providers/otp_provider.dart';
import 'package:web_tut/providers/report_provider.dart';
import 'package:web_tut/providers/request_provider.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/providers/user_account_provider.dart';
import 'package:web_tut/providers/user_activity_provider.dart';
import 'package:web_tut/providers/userdata_notifier.dart';
import 'package:web_tut/screens/authentication/splash_screen.dart';
import 'package:web_tut/utils/routes.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({Key key}) : super(key: key);

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
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
        ChangeNotifierProvider(create: (_) => DrawerPageProvider2()),
        ChangeNotifierProvider(create: (_) => LocalDataProvider()),
        ChangeNotifierProvider(create: (_) => SFDataSearchProvider()),
        ChangeNotifierProvider(create: (_) => SelectionProvider()),
        ChangeNotifierProvider(create: (_) => SelectionCollegeProvider()),
        ChangeNotifierProvider(create: (_) => SelectionCourseProvider()),
        ChangeNotifierProvider(
            create: (_) => SelectionReportedForumsProvider()),
        ChangeNotifierProvider(create: (_) => SelectionRequestProvider()),
        ChangeNotifierProvider(create: (_) => AYDatesProvider()),
        ChangeNotifierProvider(create: (_) => SelectionAdminsListProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => UserAccountProvider()),
        ChangeNotifierProvider(create: (_) => AdminActivityProvider()),
        ChangeNotifierProvider(create: (_) => AdminActivitySearchProvider()),
        ChangeNotifierProvider(create: (_) => UserActivityProvider()),
        ChangeNotifierProvider(create: (_) => UserActivitySearchProvider()),
        ChangeNotifierProvider(
            create: (_) => SelectionArchivedForumsProvider()),
        ChangeNotifierProvider(create: (_) => ArchiveReportProvider()),
        ChangeNotifierProvider(create: (_) => ThreadReplyProvider()),
        ChangeNotifierProvider(create: (_) => ActivityLogDateRangeProvider()),
        ChangeNotifierProvider(create: (_) => LogTypeProvider()),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        // initialRoute: Routes.splash,
        debugShowCheckedModeBanner: false,
        title: 'UsApp Admin',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        theme: ThemeData.dark(),
        home: SplashScreen(),
        routes: Routes2.routes,
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
