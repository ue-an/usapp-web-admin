import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_tut/providers/auth_provider.dart';
import 'package:web_tut/screens/colleges_screen.dart';
import 'package:web_tut/screens/course_screen.dart';
import 'package:web_tut/screens/dashboard.dart';
import 'package:web_tut/screens/report_screen.dart';
import 'package:web_tut/screens/request_screen.dart';
import 'package:web_tut/screens/studnumbers_screen.dart';
import 'package:web_tut/screens/users_screen.dart';
import 'package:web_tut/utils/constants.dart';
import 'package:web_tut/utils/routes.dart';
import 'package:web_tut/utils/vertical_tabs.dart';

class MyPage extends StatefulWidget {
  const MyPage({
    Key key,
  }) : super(key: key);
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Future getUserAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String adminemail = prefs.getString('userstatus');
      print("==On Load Check ==");
      // print(widget.value);
      print(adminemail);
      // context.read<AdminProvider>().changeEmail = adminemail;
    });
  }

  @override
  void initState() {
    super.initState();

    //Call check for landing page in init state of your home page widget
    getUserAdmin();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("UsApp Administrator Panel"),
        backgroundColor: kSecondaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GFButton(
              onPressed: () async {
                await context.read<AuthProvider>().signOutAdmin();
                Navigator.of(context).pushNamed(Routes.splash);
              },
              size: GFSize.SMALL,
              shape: GFButtonShape.pills,
              color: GFColors.TRANSPARENT,
              elevation: 0,
              focusElevation: 0,
              hoverColor: kMiddleColor,
              splashColor: GFColors.TRANSPARENT,
              buttonBoxShadow: false,
              highlightColor: GFColors.TRANSPARENT,
              highlightElevation: 0,
              hoverElevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Image.asset('assets/images/ic_exit-24.png'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: VerticalTabs(
        tabsWidth: (() {
          //large
          if (size.height > 770) {
            if (size.width > 1400) {
              return size.width / 7;
            }
            if (size.width > 670) {
              return size.width / 7;
            } else {
              return 0;
            }
          }
          //mid
          if (size.height > 670) {
            if (size.width > 1400) {
              return size.width / 7;
            }
            if (size.width > 670) {
              return size.width / 7;
            } else {
              return size.width / 7;
            }
          }
          //small
          else {
            if (size.width > 1400) {
              return size.width / 7;
            }
            if (size.width > 670) {
              return size.width / 7;
            } else {
              return size.width / 7;
            }
          }
        }()),
        direction: TextDirection.ltr,
        contentScrollAxis: Axis.vertical,
        changePageDuration: const Duration(milliseconds: 500),
        tabs: (() {
          //large
          if (size.height > 770) {
            if (size.width > 1400) {
              return <Tab>[
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 9,
                      ),
                      Image.asset('assets/images/ic_urs-24.png'),
                      const SizedBox(
                        width: 9,
                      ),
                      const Expanded(
                          child: Text(
                        'Dashboard',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      )),
                    ],
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.group,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Users",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.assignment_ind,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Students",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.account_balance,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Colleges",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.menu_book,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Courses",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.report_gmailerrorred,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Reports",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.mark_email_unread_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Requests",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ];
            } else {
              return <Tab>[
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ic_urs-24.png',
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.group,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.assignment_ind,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.account_balance,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.menu_book,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.report_gmailerrorred,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.mark_email_unread_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ];
            }
          }
          //small
          else {
            if (size.width > 1400) {
              return <Tab>[
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 9,
                      ),
                      Image.asset('assets/images/ic_urs-24.png'),
                      const SizedBox(
                        width: 9,
                      ),
                      const Expanded(
                          child: Text(
                        'Dashboard',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      )),
                    ],
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.group,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Users",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.assignment_ind,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Students",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.account_balance,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Colleges",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.menu_book,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Courses",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.report_gmailerrorred,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Reports",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.mark_email_unread,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Requests",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ];
            } else {
              return <Tab>[
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/ic_urs-24.png'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.group,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.assignment_ind,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.account_balance,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.menu_book,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.report_gmailerrorred,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.mark_email_unread,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ];
            }
          }
        }()),
        contents: <Widget>[
          Dashboard(),
          const UsersScreen(),
          StudnumbersScreen(),
          CollegesScreen(),
          CourseScreen(),
          ReportScreen(),
          RequestScreen(),
        ],
      ),
    );
  }

  Widget tabsContent(String caption, [String description = '']) {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          Text(
            caption,
            style: const TextStyle(fontSize: 25),
          ),
          const Divider(
            height: 20,
            color: Colors.black45,
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
