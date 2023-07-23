import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_tut/2.0/providers/drawerpage_provider.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/providers/auth_provider.dart';
import 'package:web_tut/utils/constants.dart';
import 'package:web_tut/utils/routes.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String _myUsertype;
  getUsertype() async {
    String myUsertype =
        await context.read<LocalDataProvider>().getLocalAdminUsertype();
    setState(() {
      _myUsertype = myUsertype;
    });
  }

  @override
  void initState() {
    getUsertype();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/UsAppLogoWelcome2.png"),
          ),
          DrawerListTile(
            imageasset: 'assets/images/ic_urs-24.png',
            title: Text(
              "Dashboard",
              style: TextStyle(
                  color:
                      context.read<DrawerPageProvider2>().drawerPageSelected ==
                              0
                          ? kMiddleColor
                          : Colors.white54),
            ),
            svgSrc: "",
            press: () {
              context.read<DrawerPageProvider2>().changeDrawerPageSelected = 0;
            },
          ),
          DrawerListTile(
            imageasset: '',
            title: Text(
              "Students",
              style: TextStyle(
                  color:
                      context.watch<DrawerPageProvider2>().drawerPageSelected ==
                              1
                          ? kMiddleColor
                          : Colors.white54),
            ),
            svgSrc: "",
            icon: Icons.assignment_ind,
            press: () {
              context.read<DrawerPageProvider2>().changeDrawerPageSelected = 1;
            },
          ),
          DrawerListTile(
            imageasset: '',
            title: Text(
              "Colleges",
              style: TextStyle(
                  color:
                      context.watch<DrawerPageProvider2>().drawerPageSelected ==
                              2
                          ? kMiddleColor
                          : Colors.white54),
            ),
            svgSrc: "",
            icon: Icons.account_balance,
            press: () {
              context.read<DrawerPageProvider2>().changeDrawerPageSelected = 2;
            },
          ),
          DrawerListTile(
            imageasset: '',
            title: Text(
              "Courses",
              style: TextStyle(
                  color:
                      context.watch<DrawerPageProvider2>().drawerPageSelected ==
                              3
                          ? kMiddleColor
                          : Colors.white54),
            ),
            svgSrc: "",
            icon: Icons.school,
            press: () {
              context.read<DrawerPageProvider2>().changeDrawerPageSelected = 3;
            },
          ),
          DrawerListTile(
            imageasset: '',
            title: Text(
              "Reported \nForums",
              style: TextStyle(
                  color:
                      context.watch<DrawerPageProvider2>().drawerPageSelected ==
                              4
                          ? kMiddleColor
                          : Colors.white54),
            ),
            svgSrc: "",
            icon: Icons.report_gmailerrorred,
            press: () {
              context.read<DrawerPageProvider2>().changeDrawerPageSelected = 4;
            },
          ),
          DrawerListTile(
            imageasset: '',
            title: Text(
              "Update Details \nRequests",
              style: TextStyle(
                  color:
                      context.watch<DrawerPageProvider2>().drawerPageSelected ==
                              5
                          ? kMiddleColor
                          : Colors.white54),
            ),
            svgSrc: "",
            icon: Icons.mark_email_unread,
            press: () {
              context.read<DrawerPageProvider2>().changeDrawerPageSelected = 5;
            },
          ),
          _myUsertype == 'superadmin'
              ? DrawerListTile(
                  imageasset: '',
                  title: Text(
                    "Activity Log",
                    style: TextStyle(
                        color: context
                                    .watch<DrawerPageProvider2>()
                                    .drawerPageSelected ==
                                6
                            ? kMiddleColor
                            : Colors.white54),
                  ),
                  svgSrc: "",
                  icon: Icons.menu_book,
                  press: () {
                    context
                        .read<DrawerPageProvider2>()
                        .changeDrawerPageSelected = 6;
                  },
                )
              : Container(),
          _myUsertype == 'superadmin'
              ? DrawerListTile(
                  imageasset: '',
                  title: Text(
                    "Set Dates",
                    style: TextStyle(
                        color: context
                                    .watch<DrawerPageProvider2>()
                                    .drawerPageSelected ==
                                7
                            ? kMiddleColor
                            : Colors.white54),
                  ),
                  svgSrc: "",
                  icon: Icons.date_range_sharp,
                  press: () {
                    context
                        .read<DrawerPageProvider2>()
                        .changeDrawerPageSelected = 7;
                  },
                )
              : Container(),
          _myUsertype == 'superadmin'
              ? DrawerListTile(
                  imageasset: '',
                  title: Text(
                    "Administrators",
                    style: TextStyle(
                        color: context
                                    .watch<DrawerPageProvider2>()
                                    .drawerPageSelected ==
                                8
                            ? kMiddleColor
                            : Colors.white54),
                  ),
                  svgSrc: "",
                  icon: Icons.admin_panel_settings,
                  press: () {
                    context
                        .read<DrawerPageProvider2>()
                        .changeDrawerPageSelected = 8;
                  },
                )
              : Container(),
          _myUsertype == 'superadmin'
              ? DrawerListTile(
                  imageasset: '',
                  title: Text(
                    "User Accounts",
                    style: TextStyle(
                        color: context
                                    .watch<DrawerPageProvider2>()
                                    .drawerPageSelected ==
                                9
                            ? kMiddleColor
                            : Colors.white54),
                  ),
                  svgSrc: "",
                  icon: Icons.mobile_friendly_sharp,
                  press: () {
                    context
                        .read<DrawerPageProvider2>()
                        .changeDrawerPageSelected = 9;
                  },
                )
              : Container(),
          const Divider(
            color: Colors.grey,
          ),
          DrawerListTile(
            imageasset: 'assets/images/ic_exit-24.png',
            title: const Text(
              "Sign out",
              style: TextStyle(color: Colors.white54),
            ),
            svgSrc: "",
            press: () async {
              SharedPreferences adminDetailsPrefs =
                  await SharedPreferences.getInstance();
              adminDetailsPrefs.reload();
              await adminDetailsPrefs.remove('localadmin-name');
              await adminDetailsPrefs.remove('localadmin-email');
              await adminDetailsPrefs.remove('localadmin-usertype');
              await context.read<AuthProvider>().signOutAdmin();
              Navigator.of(context).pushNamed(Routes.splash);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    this.title,
    this.svgSrc,
    this.icon,
    this.imageasset,
    this.press,
  }) : super(key: key);

  final Text title;
  final String svgSrc, imageasset;
  final VoidCallback press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Row(
        children: [
          (imageasset == null)
              ? Container()
              : (icon == null)
                  ? Image.asset(imageasset)
                  : Icon(
                      icon,
                      color: Colors.white,
                    ),
          const SizedBox(
            width: 21,
          ),
          // Text(
          //   title,
          //   style: const TextStyle(color: Colors.white54),
          // ),
          title,
        ],
      ),
    );
  }
}
