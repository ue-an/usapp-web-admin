import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/2.0/providers/drawerpage_provider.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/auth_provider.dart';
import 'package:web_tut/screens/advanced_datatable/adv_home.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';
import 'package:getwidget/getwidget.dart';
import 'package:web_tut/utils/routes.dart';

// bool _email = false;

class LoginScreen extends StatefulWidget {
  final Function onSignUpSelected;
  final Size size;
  const LoginScreen({Key key, this.size, this.onSignUpSelected})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirestoreService firestoreService2 = FirestoreService();
  final _formKeyResetEmail = GlobalKey<FormState>();

  bool _isObscure = true;
  Widget _authScreen(BuildContext context, AuthProvider authProvider) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(widget.size.height > 770
          ? 64
          : widget.size.height > 670
              ? 32
              : 16),
      child: Center(
        child: Card(
          elevation: 9,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: kPrimaryColor,
              width: 6,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white,
            ),
            duration: const Duration(milliseconds: 200),
            height: widget.size.height *
                (widget.size.height > 770
                    ? 0.7
                    : widget.size.height > 670
                        ? 0.8
                        : 0.9),
            width: 500,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 30,
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        onChanged: (value) => authProvider.email = value,
                        // controller: _emailCtrl,
                        // onChanged: (value) =>
                        //     context.watch<AuthProvider>().changeEmail = value,
                        // widget.authProvider.changeEmail = value,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2,
                            ),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: kPrimaryColor,
                          ),
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: kPrimaryColor,
                          ),
                        ),
                        cursorColor: kPrimaryColor,
                        style: TextStyle(color: kPrimaryColor),
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        onChanged: (value) => authProvider.password = value,
                        // controller: _password,
                        // onChanged: (value) =>
                        //     context.read<AuthProvider>().changePassword = value,
                        // widget.authProvider.changeEmail = value,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2,
                            ),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: kPrimaryColor,
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: IconButton(
                            icon: _isObscure
                                ? Icon(
                                    Icons.visibility,
                                    color: kPrimaryColor,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: kPrimaryColor,
                                  ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        obscureText: _isObscure,
                        cursorColor: kPrimaryColor,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Stack(
                                    children: [
                                      Center(
                                        child: Card(
                                          elevation: 9,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: kPrimaryColor,
                                              width: 6,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(25),
                                            ),
                                          ),
                                          child: AnimatedContainer(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              color: Colors.white,
                                            ),
                                            duration: const Duration(
                                                milliseconds: 200),
                                            height: size.height *
                                                (size.height > 770
                                                    ? 0.6
                                                    : size.height > 670
                                                        ? 0.7
                                                        : 0.8),
                                            width: 500,
                                            child: Center(
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(40),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "RESET PASSWORD",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Colors.grey[700],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: 30,
                                                        child: Divider(
                                                          color: kPrimaryColor,
                                                          thickness: 2,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 32,
                                                      ),
                                                      Form(
                                                        key: _formKeyResetEmail,
                                                        child: TextFormField(
                                                            onChanged: (value) => context
                                                                    .read<
                                                                        AuthProvider>()
                                                                    .changeResetEmail =
                                                                value,
                                                            decoration:
                                                                InputDecoration(
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24.0),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  width: 2,
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24.0),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  width: 2,
                                                                ),
                                                              ),
                                                              labelText:
                                                                  'Email',
                                                              labelStyle:
                                                                  TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    kPrimaryColor,
                                                              ),
                                                              prefixIcon: Icon(
                                                                Icons
                                                                    .mail_outline,
                                                                color:
                                                                    kPrimaryColor,
                                                              ),
                                                            ),
                                                            cursorColor:
                                                                kPrimaryColor,
                                                            style: TextStyle(
                                                                color:
                                                                    kPrimaryColor),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Please provide your email';
                                                              } else {
                                                                if (!EmailValidator
                                                                    .validate(
                                                                        value)) {
                                                                  return 'Please provide a valid email';
                                                                }
                                                                return null;
                                                              }
                                                            }),
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      GFButton(
                                                        onPressed: () async {
                                                          if (_formKeyResetEmail
                                                              .currentState
                                                              .validate()) {
                                                            //send reset mail
                                                            await context
                                                                .read<
                                                                    AuthProvider>()
                                                                .resetPassword();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Reset password sent to email'),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      2000),
                                                            ));
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          }
                                                        },
                                                        shape:
                                                            GFButtonShape.pills,
                                                        fullWidthButton: true,
                                                        color: kPrimaryColor,
                                                        size: GFSize.LARGE,
                                                        text:
                                                            'Send password reset email',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // right: -40.0,
                                        // right: size.width / 2.78,
                                        right: size.width / 3,
                                        top: size.height * .190,
                                        // right: size.width * .385,
                                        // top: size.height * .198,
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
                            child: const Text(
                              'Forgot Password? ',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 54,
                      ),
                      GFButton(
                        onPressed: () async {
                          if (authProvider.email != '' &&
                              authProvider.password != '') {
                            await authProvider.checkAdminsColl();
                            if (authProvider.isVerifiedAdminEmail == true) {
                              await authProvider.checkAdminsEnabled();
                              if (authProvider.isEnabled == true) {
                                await authProvider.logInAdmin();
                                if (authProvider.isVerifiedAcct == true) {
                                  print('object');
                                  //get first time admin credentials from firebase
                                  var data = firestoreService2.getAdmins();
                                  List<Admin> adminDetails = await data.first;
                                  //store in localdata sharedprefs
                                  for (var admin in adminDetails) {
                                    await context
                                        .read<LocalDataProvider>()
                                        .storeLocalAdminEmail(admin.email);
                                    await context
                                        .read<LocalDataProvider>()
                                        .storeLocalAdminName(admin.adminName);
                                    await context
                                        .read<LocalDataProvider>()
                                        .storeLocalAdminUsertype(
                                            admin.usertype);
                                    context
                                        .read<DrawerPageProvider2>()
                                        .changeDrawerPageSelected = 0;
                                    Navigator.of(context)
                                        .pushReplacementNamed(Routes.splash);
                                  }
                                } else {
                                  print('no no no');
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Row(
                                          children: [
                                            Icon(
                                              Icons.warning,
                                              color: kPrimaryColor,
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text('Incorrect Input'),
                                          ],
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text(
                                                  'Wrong username or password'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            color: kPrimaryColor,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text('Access Denied'),
                                        ],
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text(
                                                'Account with this email is disabled'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text('Email is invalid'),
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const <Widget>[
                                          Text('Email address does not exist'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        color: kPrimaryColor,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text('Empty Fields'),
                                    ],
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text('Please provied all fields'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          // await authProvider.logInAdmin();
                          // Navigator.of(context).pushNamed(Routes.splash);
                        },
                        shape: GFButtonShape.pills,
                        fullWidthButton: true,
                        color: kPrimaryColor,
                        text: 'Log In',
                        size: GFSize.LARGE,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       "You do not have an account?",
                      //       style: TextStyle(
                      //         color: Colors.grey,
                      //         fontSize: 14,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 8,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           widget.onSignUpSelected();
                      //         });
                      //       },
                      //       child: Row(
                      //         children: [
                      //           Text(
                      //             "Sign Up",
                      //             style: TextStyle(
                      //               color: kPrimaryColor,
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           const SizedBox(
                      //             width: 8,
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward,
                      //             color: kPrimaryColor,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) =>
          _authScreen(context, authProvider),
    );
  }
}
