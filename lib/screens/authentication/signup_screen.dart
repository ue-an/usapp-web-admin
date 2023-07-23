import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/providers/otp_provider.dart';
import 'package:web_tut/utils/constants.dart';
import 'package:web_tut/utils/routes.dart';

class SignupScreen extends StatefulWidget {
  final Function onLoginSelected;
  final Size size;
  const SignupScreen({Key key, this.onLoginSelected, this.size})
      : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();
    emailAuth = EmailAuth(
        sessionName: "UsApp: URS Messaging and Forum App Admin Registration");
  }

  void sendOTP() async {
    bool res = await emailAuth.sendOtp(
        recipientMail: _emailCtrl.value.text, otpLength: 5);
    if (res) {
      print("OTP Sent");
      context.read<OtpProvider>().changeSubmitValid = true;
      context.read<OtpProvider>().changeEmail = _emailCtrl.value.text;
      print(context.read<OtpProvider>().email);
    }
  }

  void verifyOTP() {
    bool res = emailAuth.validateOtp(
        recipientMail: _emailCtrl.value.text, userOtp: _otpCtrl.value.text);
    if (res) {
      print("OTP Verified");
      context.read<OtpProvider>().changeIsVerified = true;
    } else {
      print("OTP Not Verified");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.size.height > 770
          ? 64
          : widget.size.height > 670
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
                color: Colors.white,
                border: Border.all(
                  color: kPrimaryColor,
                  width: 6,
                )),
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
                        "SIGN UP",
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
                        controller: _emailCtrl,
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
                          suffix: TextButton(
                            onPressed: () {
                              sendOTP();
                            },
                            child: const Text('Send OTP'),
                          ),
                        ),
                        cursorColor: kPrimaryColor,
                        style: TextStyle(color: kPrimaryColor),
                      ),

                      const SizedBox(
                        height: 32,
                      ),

                      (context.watch<OtpProvider>().submitValid)
                          ? Column(
                              children: [
                                TextFormField(
                                  controller: _otpCtrl,
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
                                    labelText: 'OTP',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: kPrimaryColor,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  cursorColor: kPrimaryColor,
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                                const SizedBox(
                                  height: 64,
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: kPrimaryColor.withOpacity(0.2),
                                        spreadRadius: 4,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {
                                        verifyOTP();
                                        (context.read<OtpProvider>().isVerified)
                                            ? Navigator.pushNamed(
                                                context, Routes.create)
                                            // : Center(child: Container(height: 100, width: 100, color: Colors.red,));
                                            : print('not');
                                      },
                                      child: const Text(
                                        'Verify OTP',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              height: 1,
                            ),

                      // actionButton("Create Account"),

                      const SizedBox(
                        height: 32,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.onLoginSelected();
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: kPrimaryColor,
                                ),
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
        ),
      ),
    );
  }
}
