import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/administrators_list/components/selection_adminslist_provider.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/selection_reportedforums_provider.dart';
import 'package:web_tut/2.0/utils/routes2.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/admin_provider.dart';
import 'package:web_tut/providers/report_provider.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the global keys
    final _formKeyadminName = GlobalKey<FormState>();
    final _formKeyadminEmail = GlobalKey<FormState>();
    final _formKeyadminPassword = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            // onPressed: context.read<MenuController>().controlMenu,
            onPressed: () {
              context.read<MenuController>().isClicked = true;
              context.read<MenuController>().isClicked == true
                  ? Scaffold.of(context).openDrawer()
                  : null;
            },
          ),
        if (!Responsive.isMobile(context))
          Text(
            "List of Administrators",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        GFButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: AlertDialog(
                        content: SingleChildScrollView(
                          child: Container(
                            width: size.width / 3,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            key: _formKeyadminEmail,
                                            child: TextFormField(
                                              onChanged: (value) => context
                                                  .read<AdminProvider>()
                                                  .changeAdminEmail = value,
                                              decoration: const InputDecoration(
                                                labelText: 'Email',
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please provide an email';
                                                } else {
                                                  if (!EmailValidator.validate(
                                                      value)) {
                                                    return 'Please provide a valid email';
                                                  }
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            key: _formKeyadminName,
                                            child: TextFormField(
                                              onChanged: (value) => context
                                                  .read<AdminProvider>()
                                                  .changeAdminName = value,
                                              decoration: const InputDecoration(
                                                labelText: 'Admin Name',
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please provide an admin name';
                                                } else {
                                                  if (value.length < 6) {
                                                    return 'Name is too short. Must be at least 6 characters.';
                                                  }
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            key: _formKeyadminPassword,
                                            child: TextFormField(
                                              obscureText: true,
                                              onChanged: (value) => context
                                                  .read<AdminProvider>()
                                                  .changeAdminPassword = value,
                                              decoration: const InputDecoration(
                                                labelText: 'Password',
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please provide a password';
                                                } else {
                                                  RegExp regex = RegExp(
                                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                                                  if (value.length < 9) {
                                                    return 'New password is too short. Must be at least 9 characters.';
                                                  }
                                                  if (!regex.hasMatch(value)) {
                                                    return 'New password is too weak. Must include: \n1 uppercase\n1 lowercase\n1 numeric number\n1 special character';
                                                  }
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GFButton(
                                              onPressed: () async {
                                                if ((_formKeyadminEmail
                                                            .currentState
                                                            .validate() &&
                                                        _formKeyadminName
                                                            .currentState
                                                            .validate()) &&
                                                    _formKeyadminPassword
                                                        .currentState
                                                        .validate()) {
                                                  //create activity
                                                  String myName = await context
                                                      .read<LocalDataProvider>()
                                                      .getLocalAdminName();
                                                  context
                                                          .read<
                                                              AdminActivityProvider>()
                                                          .changeActivityTitle =
                                                      'Added an Administrator';
                                                  context
                                                      .read<
                                                          AdminActivityProvider>()
                                                      .changeName = myName;
                                                  context
                                                      .read<
                                                          AdminActivityProvider>()
                                                      .changeDate = DateTime.now();
                                                  await context
                                                      .read<
                                                          AdminActivityProvider>()
                                                      .addActivity();
                                                  await context
                                                      .read<AdminProvider>()
                                                      .registerAdmin();
                                                  await context
                                                      .read<AdminProvider>()
                                                      .createAdminAccount();
                                                  //show snackbar
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Successfully added.')),
                                                  );
                                                  Navigator.pop(context);
                                                }
                                              },
                                              text: 'Save',
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // right: -40.0,
                      right: size.width * .3,
                      top: 3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const CircleAvatar(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.add),
              Text('Admin'),
            ],
          ),
        ),
      ],
    );
  }
}
