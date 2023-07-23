import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/providers/drawerpage_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/activity_log_screen.dart';
import 'package:web_tut/2.0/screens/admin_profile/admin_profile.dart';
import 'package:web_tut/2.0/screens/administrators_list/administrators_list_screen.dart';
import 'package:web_tut/2.0/screens/colleges/colleges_screen2.dart';
import 'package:web_tut/2.0/screens/colleges/components/selection_college_provider.dart';
import 'package:web_tut/2.0/screens/courses/courses_screen2.dart';
import 'package:web_tut/2.0/screens/dashboard/dashboard_screen.dart';
import 'package:web_tut/2.0/screens/reported_forums/reported_forums_screen2.dart';
import 'package:web_tut/2.0/screens/courses/components/selection_course_provider.dart';
import 'package:web_tut/2.0/screens/set_dates/set_dates_screen.dart';
import 'package:web_tut/2.0/screens/students/components/selection_provider.dart';
import 'package:web_tut/2.0/screens/students/students_screen2.dart';
import 'package:web_tut/2.0/screens/update_details_request/update_request_screen2.dart';
import 'package:web_tut/2.0/screens/user_accounts/mobile_user_accounts_screen.dart';
import 'package:web_tut/screens/view_archive_threads.dart';
import 'package:web_tut/screens/view_thread_convo.dart';

import '../../responsive.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: (() {
                switch (
                    context.watch<DrawerPageProvider2>().drawerPageSelected) {
                  case 0:
                    //dashboard
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data (data table)',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return DashboardScreen();
                  // return ActivityLogScreen();
                  case 1:
                    //students
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return StudentsScreen2();
                  case 2:
                    //colleges
                    return context
                                .read<SelectionCourseProvider>()
                                .haveSelections ==
                            true
                        ? Container(
                            child: const Center(
                              child: Text(
                                  'Please cancel all selection operations'),
                            ),
                          )
                        : const CollegesScreen2();
                  // return Container(
                  //   child: const Center(
                  //     child: Text(
                  //       'Working. Temporarily disabled\nto save data',
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // );
                  case 3:
                    //courses
                    return context
                                .read<SelectionCollegeProvider>()
                                .haveSelections ==
                            true
                        ? Container(
                            child: const Center(
                              child: Text(
                                  'Please cancel all selection operations'),
                            ),
                          )
                        : const CoursesScreen2();
                  // return Container(
                  //   child: const Center(
                  //     child: Text(
                  //       'Working. Temporarily disabled\nto save data',
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // );
                  case 4:
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return const ReportedForumsScreen2();
                  case 5:
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return const UpdateRequestScreen2();
                  case 6:
                    // return Container(
                    //   color: Colors.cyan,
                    // );
                    return ActivityLogScreen();
                  case 7:
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return SetDatesScreen();
                  case 8:
                    //admin screen
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return AdministratorsListScreen();
                  case 9:
                    //user account screen (mobile/usapp)
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return MobileUserAccountsScreen();
                  case 10:
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return AdminProfile();
                  case 11:
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return ViewThreadConvo();
                  case 12:
                    // return Container(
                    //   child: const Center(
                    //     child: Text(
                    //       'Working. Temporarily disabled\nto save data',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                    return ViewArchiveThreadConvo();

                  default:
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.red,
                        ),
                      ],
                    );
                }
              }()),
            ),
          ],
        ),
      ),
    );
  }
}
