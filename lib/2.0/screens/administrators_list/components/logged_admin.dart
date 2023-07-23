import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/auth_provider.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';

class LoggedAdmin extends StatefulWidget {
  const LoggedAdmin({Key key}) : super(key: key);

  @override
  State<LoggedAdmin> createState() => _LoggedAdminState();
}

class _LoggedAdminState extends State<LoggedAdmin>
    with AutomaticKeepAliveClientMixin<LoggedAdmin> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<Admin>> _streamLoggedAdmin;
  // Define the global keys
  final _formKeyOldPassword = GlobalKey<FormState>();
  final _formKeyNewPassword = GlobalKey<FormState>();
  final _formKeyReNewPassword = GlobalKey<FormState>();
  @override
  void initState() {
    _streamLoggedAdmin = firestoreService.getAdmins();
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return StreamBuilder<List<Admin>>(
        stream: _streamLoggedAdmin,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    snapshot.data[0].adminName,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    snapshot.data[0].email,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Stack(
                                children: [
                                  AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Container(
                                        // width: double.maxFinite,
                                        width: _size.width / 3,
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
                                                          child: TextFormField(
                                                            obscureText: true,
                                                            onChanged: (value) => context
                                                                .read<
                                                                    AuthProvider>()
                                                                .oldPassword = value,
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'Old Password',
                                                            ),
                                                            validator: (value) {
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
                                                            onPressed: () {
                                                              //check if old password is correct
                                                              if (_formKeyOldPassword
                                                                  .currentState
                                                                  .validate()) {
                                                                context
                                                                    .read<
                                                                        AuthProvider>()
                                                                    .validateOldPassword();
                                                              }
                                                            },
                                                            text: 'Confirm',
                                                          ),
                                                        ],
                                                      ),
                                                      context
                                                                  .watch<
                                                                      AuthProvider>()
                                                                  .oldPassCorrect ==
                                                              true
                                                          ? Column(children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Form(
                                                                  key:
                                                                      _formKeyNewPassword,
                                                                  child:
                                                                      TextFormField(
                                                                    obscureText:
                                                                        true,
                                                                    onChanged: (value) => context
                                                                        .read<
                                                                            AuthProvider>()
                                                                        .newPassword = value,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      labelText:
                                                                          'New Password',
                                                                    ),
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
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
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Form(
                                                                  key:
                                                                      _formKeyReNewPassword,
                                                                  child:
                                                                      TextFormField(
                                                                    obscureText:
                                                                        true,
                                                                    onChanged: (value) => context
                                                                        .read<
                                                                            AuthProvider>()
                                                                        .reNewPass = value,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      labelText:
                                                                          'Retype New Password',
                                                                    ),
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'Please re-enter new password';
                                                                      } else {
                                                                        RegExp
                                                                            regex =
                                                                            RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                                                        if (value !=
                                                                            context.read<AuthProvider>().newPassword) {
                                                                          return 'New password does not match.';
                                                                        }
                                                                        if (value.length <
                                                                            9) {
                                                                          return 'New password is too short. Must be at least 9 characters.';
                                                                        }
                                                                        if (!regex
                                                                            .hasMatch(value)) {
                                                                          return 'New password is too weak. Must include: \n1 uppercase\n1 lowercase\n1 numeric number\n1 special character';
                                                                        }
                                                                        if (value ==
                                                                            context.read<AuthProvider>().oldPassword) {
                                                                          return 'Do not use same old password.';
                                                                        }
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
                                                                      //check if new password and retype new password are matched
                                                                      if (_formKeyNewPassword
                                                                              .currentState
                                                                              .validate() &&
                                                                          _formKeyReNewPassword
                                                                              .currentState
                                                                              .validate()) {
                                                                        await context
                                                                            .read<AuthProvider>()
                                                                            .changePassword();
                                                                        context
                                                                            .read<AuthProvider>()
                                                                            .oldPassCorrect = false;
                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Password successfully changed.')));
                                                                        Future.delayed(
                                                                            const Duration(seconds: 1),
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        });
                                                                      }
                                                                      //create activity
                                                                      String
                                                                          myName =
                                                                          await context
                                                                              .read<LocalDataProvider>()
                                                                              .getLocalAdminName();
                                                                      context
                                                                          .read<
                                                                              AdminActivityProvider>()
                                                                          .changeActivityTitle = 'Changed password';
                                                                      context
                                                                          .read<
                                                                              AdminActivityProvider>()
                                                                          .changeName = myName;
                                                                      context
                                                                          .read<
                                                                              AdminActivityProvider>()
                                                                          .changeDate = DateTime.now();
                                                                      //pdf preview here
                                                                      context
                                                                          .read<
                                                                              AdminActivityProvider>()
                                                                          .addActivity();
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
                                  Positioned(
                                    // right: -40.0,
                                    right: _size.width * .3,
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
                              ),
                            );
                          });
                    },
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'Logged in',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: kMiddleColor,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
