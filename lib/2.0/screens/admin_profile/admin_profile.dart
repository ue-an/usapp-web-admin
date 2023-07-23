import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/screens/admin_profile/components/header.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/auth_provider.dart';
import 'package:web_tut/utils/constants.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  // Define the global keys
  final _formKeyOldPassword = GlobalKey<FormState>();
  final _formKeyNewPassword = GlobalKey<FormState>();
  final _formKeyReNewPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            SizedBox(height: size.height / 12),
            Container(
              padding: const EdgeInsets.only(
                left: defaultPadding,
                right: defaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name: ',
                    style: TextStyle(
                      fontSize: 21,
                      color: kMiddleColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  FutureBuilder<String>(
                    future:
                        context.read<LocalDataProvider>().getLocalAdminName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data,
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        );
                      } else {
                        return Text('No Name');
                      }
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Divider(),
                  const SizedBox(height: defaultPadding),
                  Text(
                    'Email: ',
                    style: TextStyle(
                      fontSize: 21,
                      color: kMiddleColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  FutureBuilder<String>(
                    future:
                        context.read<LocalDataProvider>().getLocalAdminEmail(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data,
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        );
                      } else {
                        return Text('No Name');
                      }
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Divider(),
                  const SizedBox(height: defaultPadding),
                  Text(
                    'Usertype: ',
                    style: TextStyle(
                      fontSize: 21,
                      color: kMiddleColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  FutureBuilder<String>(
                    future: context
                        .read<LocalDataProvider>()
                        .getLocalAdminUsertype(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data,
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        );
                      } else {
                        return Text('No Name');
                      }
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Divider(),
                  const SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GFButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Container(
                                            // width: double.maxFinite,
                                            width: size.width / 3,
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Form(
                                                              key:
                                                                  _formKeyOldPassword,
                                                              child:
                                                                  TextFormField(
                                                                obscureText:
                                                                    true,
                                                                onChanged: (value) => context
                                                                    .read<
                                                                        AuthProvider>()
                                                                    .oldPassword = value,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  labelText:
                                                                      'Old Password',
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please enter old password';
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              GFButton(
                                                                onPressed:
                                                                    () async {
                                                                  //check if old password is correct
                                                                  if (_formKeyOldPassword
                                                                      .currentState
                                                                      .validate()) {
                                                                    await context
                                                                        .read<
                                                                            AuthProvider>()
                                                                        .validateOldPassword();
                                                                    // context
                                                                    //         .read<
                                                                    //             AuthProvider>()
                                                                    //         .oldPassCorrect
                                                                    //     ? print(
                                                                    //         'correct')
                                                                    //     : print(
                                                                    //         'wrong');
                                                                  }
                                                                },
                                                                text: 'Confirm',
                                                              ),
                                                            ],
                                                          ),
                                                          context
                                                                  .watch<
                                                                      AuthProvider>()
                                                                  .oldPassCorrect
                                                              ? Column(
                                                                  children: [
                                                                      Container(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Form(
                                                                          key:
                                                                              _formKeyNewPassword,
                                                                          child:
                                                                              TextFormField(
                                                                            obscureText:
                                                                                true,
                                                                            onChanged: (value) =>
                                                                                context.read<AuthProvider>().newPassword = value,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              labelText: 'New Password',
                                                                            ),
                                                                            validator:
                                                                                (value) {
                                                                              if (value == null || value.isEmpty) {
                                                                                return 'Please enter new password';
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Form(
                                                                          key:
                                                                              _formKeyReNewPassword,
                                                                          child:
                                                                              TextFormField(
                                                                            obscureText:
                                                                                true,
                                                                            onChanged: (value) =>
                                                                                context.read<AuthProvider>().reNewPass = value,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              labelText: 'Retype New Password',
                                                                            ),
                                                                            validator:
                                                                                (value) {
                                                                              if (value == null || value.isEmpty) {
                                                                                return 'Please re-enter new password';
                                                                              } else {
                                                                                RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                                                                if (value != context.read<AuthProvider>().newPassword) {
                                                                                  return 'New password does not match.';
                                                                                }
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
                                                                            onPressed:
                                                                                () async {
                                                                              //check if new password and retype new password are matched
                                                                              if (_formKeyNewPassword.currentState.validate() && _formKeyReNewPassword.currentState.validate()) {
                                                                                await context.read<AuthProvider>().changePassword();
                                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password successfully changed.')));
                                                                                Future.delayed(const Duration(seconds: 1), () {
                                                                                  Navigator.pop(context);
                                                                                });
                                                                              }
                                                                              //create activity
                                                                              String myName = await context.read<LocalDataProvider>().getLocalAdminName();

                                                                              context.read<AdminActivityProvider>().changeActivityTitle = 'Changed password';
                                                                              context.read<AdminActivityProvider>().changeName = myName;
                                                                              context.read<AdminActivityProvider>().changeDate = DateTime.now();
                                                                              context.read<AdminActivityProvider>().addActivity();
                                                                            },
                                                                            text:
                                                                                'Save',
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ])
                                                              : Container(),
                                                        ],
                                                      ),
                                                    ),
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
                              });
                        },
                        text: 'Change Password',
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
