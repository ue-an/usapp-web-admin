import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_tut/providers/otp_provider.dart';
import 'package:web_tut/utils/constants.dart';
import 'package:web_tut/utils/routes.dart';

class CreateAcctScreen extends StatefulWidget {
  const CreateAcctScreen({Key key}) : super(key: key);

  @override
  _CreateAcctScreenState createState() => _CreateAcctScreenState();
}

class _CreateAcctScreenState extends State<CreateAcctScreen> {
  Widget _createScreen(BuildContext context, OtpProvider otpProvider) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.height > 770
            ? 64
            : size.height > 670
                ? 32
                : 16),
        child: Center(
          child: Card(
            elevation: 9,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 6,
                  color: kPrimaryColor,
                ),
                color: Colors.white,
              ),
              duration: const Duration(milliseconds: 200),
              height: size.height *
                  (size.height > 770
                      ? 0.7
                      : size.height > 670
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
                          "Register Admin",
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: (otpProvider.email == null)
                                    // ? Text(
                                    //     'Your Email',
                                    //     style: TextStyle(color: kPrimaryColor),
                                    //   )
                                    ? Text(
                                        'Your Email',
                                        style: TextStyle(color: kPrimaryColor),
                                      )
                                    : Text(
                                        otpProvider.email,
                                        style: TextStyle(color: kPrimaryColor),
                                      )),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          onChanged: (value) =>
                              otpProvider.changeAdminName = value,
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
                            labelText: 'Admin Name',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor,
                            ),
                            prefixIcon: Icon(
                              Icons.account_circle_outlined,
                              color: kPrimaryColor,
                            ),
                          ),
                          cursorColor: kPrimaryColor,
                          style: TextStyle(color: kPrimaryColor),
                        ),

                        const SizedBox(
                          height: 32,
                        ),

                        TextFormField(
                          onChanged: (value) =>
                              otpProvider.changePassword = value,
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
                          ),
                          obscureText: true,
                          cursorColor: kPrimaryColor,
                          style: TextStyle(color: kPrimaryColor),
                        ),

                        const SizedBox(
                          height: 32,
                        ),

                        TextFormField(
                          onChanged: (value) =>
                              otpProvider.changeRepass = value,
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
                            labelText: 'Re-type Password',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: kPrimaryColor,
                            ),
                          ),
                          obscureText: true,
                          cursorColor: kPrimaryColor,
                          style: TextStyle(color: kPrimaryColor),
                        ),

                        const SizedBox(
                          height: 64,
                        ),

                        // actionButton("Log In"),

                        GFButton(
                          onPressed: () async {
                            if (otpProvider.password == otpProvider.repass) {
                              otpProvider.saveAdmin();
                              otpProvider.adminToCollection();
                            } else {
                              print('password does not match');
                            }
                            print(otpProvider.password +
                                "=" +
                                otpProvider.repass);
                            print(otpProvider.email);
                            print(otpProvider.adminName);
                          },
                          shape: GFButtonShape.pills,
                          fullWidthButton: true,
                          color: kPrimaryColor,
                          text: 'Create Account',
                          size: GFSize.LARGE,
                        ),

                        const SizedBox(
                          height: 32,
                        ),

                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
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
    return Consumer<OtpProvider>(
      builder: (context, otpProvider, child) =>
          _createScreen(context, otpProvider),
    );
  }
}
