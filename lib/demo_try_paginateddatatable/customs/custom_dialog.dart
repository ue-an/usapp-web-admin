import 'dart:html';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/utils/constants.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key key,
    @required this.child,
    this.showPadding = true,
    @required this.studentdata,
  }) : super(key: key);

  final Widget child;
  final bool showPadding;
  final Student studentdata;

  @override
  Widget build(BuildContext context) {
    var _child = child;

    if (showPadding) {
      _child = Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
        child: child,
      );
    } else {
      // _child = Center(
      //   child: Padding(
      //     // padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
      //     padding: const EdgeInsets.only(
      //       top: 9,
      //       bottom: 21,
      //       right: 21,
      //       left: 21,
      //     ),
      //     child: child,
      //   ),
      // );
    }
    StudentProvider studentProvider = StudentProvider();

    studentProvider.changeStudentNumber = studentdata.studentNumber;
    studentProvider.changeLastName = studentdata.lastName;
    studentProvider.changeMInitial = studentdata.mInitial;
    studentProvider.changeFirstName = studentdata.firstName;
    studentProvider.changeCourse = studentdata.course;
    studentProvider.changeYearLevel = studentdata.yearLvl.toString();
    studentProvider.changeSection = studentdata.section.toString();
    studentProvider.changeCollege = studentdata.college;
    studentProvider.changeEmail = studentdata.email;
    // studentProvider.changePhotoUrl = studentdata.photoUrl;

    // context.read<StudentProvider>().changeStudentNumber =
    //     studentdata.studentNumber;
    // context.read<StudentProvider>().changeLastName = studentdata.lastName;
    // context.read<StudentProvider>().changeMInitial = studentdata.mInitial;
    // context.read<StudentProvider>().changeFirstName = studentdata.firstName;
    // context.read<StudentProvider>().changeCourse = studentdata.course;
    // context.read<StudentProvider>().changeYearSec = studentdata.yearSec;
    // context.read<StudentProvider>().changeCollege = studentdata.college;
    // context.read<StudentProvider>().changeEmail = studentdata.email;

    return AlertDialog(
      title: Row(
        children: const [
          Icon(Icons.warning),
          SizedBox(
            width: 6,
          ),
          Text('Update/Edit Details'),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Student Number',
              style: TextStyle(color: kPrimaryColor),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              onChanged: (value) => studentProvider.changeStudentNumber = value,
              initialValue: studentdata.studentNumber,
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
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              cursorColor: kPrimaryColor,
              style: TextStyle(color: kPrimaryColor),
              validator: (email) =>
                  email != null ? 'Enter a valid student number' : null,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'First Name',
              style: TextStyle(color: kPrimaryColor),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              onChanged: (value) => studentProvider.changeFirstName = value,
              initialValue: studentdata.firstName,
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
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              cursorColor: kPrimaryColor,
              style: TextStyle(color: kPrimaryColor),
              validator: (email) => email != null ? 'Enter first name' : null,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Middle Initial',
              style: TextStyle(color: kPrimaryColor),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              onChanged: (value) => studentProvider.changeMInitial = value,
              initialValue: studentdata.mInitial,
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
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              cursorColor: kPrimaryColor,
              style: TextStyle(color: kPrimaryColor),
              validator: (email) =>
                  email != null ? 'Enter middle initial' : null,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Last Name',
              style: TextStyle(color: kPrimaryColor),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              onChanged: (value) => studentProvider.changeLastName = value,
              initialValue: studentdata.lastName,
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
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              cursorColor: kPrimaryColor,
              style: TextStyle(color: kPrimaryColor),
              validator: (email) => email != null ? 'Enter last name' : null,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Email',
              style: TextStyle(color: kPrimaryColor),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              onChanged: (value) => studentProvider.changeEmail = value,
              initialValue: studentdata.email,
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
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              cursorColor: kPrimaryColor,
              style: TextStyle(color: kPrimaryColor),
              validator: (email) =>
                  email != null ? 'Enter a valid email' : null,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Course',
              style: TextStyle(color: kPrimaryColor),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              onChanged: (value) => studentProvider.changeCourse = value,
              initialValue: studentdata.course,
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
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              cursorColor: kPrimaryColor,
              style: TextStyle(color: kPrimaryColor),
              validator: (email) => email != null ? 'Input a course' : null,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Year Level',
              style: TextStyle(color: kPrimaryColor),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) => studentProvider.changeYearLevel = value,
              initialValue: studentdata.yearLvl.toString(),
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
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              cursorColor: kPrimaryColor,
              style: TextStyle(color: kPrimaryColor),
              validator: (email) => email != null ? 'Input year levle' : null,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Section',
              style: TextStyle(color: kPrimaryColor),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              onChanged: (value) => studentProvider.changeSection = value,
              initialValue: studentdata.section.toString(),
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
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              cursorColor: kPrimaryColor,
              style: TextStyle(color: kPrimaryColor),
              validator: (email) =>
                  email != null ? 'Input year and section' : null,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'College',
              style: TextStyle(color: kPrimaryColor),
            ),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              onChanged: (value) => studentProvider.changeCollege = value,
              initialValue: studentdata.college,
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
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
              cursorColor: kPrimaryColor,
              style: TextStyle(color: kPrimaryColor),
              validator: (email) => email != null ? 'Input a college' : null,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        GFButton(
          onPressed: () async {
            String studentnumber = studentProvider.studentNumber;
            String lastname = studentProvider.lastName;
            String minitial = studentProvider.mInitial;
            String firstname = studentProvider.firstName;
            String course = studentProvider.course;
            String yearlevel = studentProvider.yearLevel;
            String section = studentProvider.section;
            String college = studentProvider.college;
            String email = studentProvider.email;

            if ((studentnumber != null && studentnumber != '') &&
                (lastname != null && lastname != '') &&
                (minitial != null && minitial != '') &&
                (firstname != null && firstname != '') &&
                (course != null && course != '') &&
                (yearlevel != null && yearlevel.toString() != '') &&
                (section != null && section.toString() != '') &&
                (college != null && college != '') &&
                (email != null && email != '')) {
              await studentProvider.saveStudent();
              Navigator.of(context).pop();
            } else {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Row(
                      children: const [
                        Icon(Icons.warning),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Invalid Input'),
                      ],
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Text('Please provide all fields'),
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
          },
          color: kPrimaryColor,
          text: 'Update',
        ),
        // SizedBox(
        //   width: 6,
        // ),
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // return Dialog(
    //   elevation: 8.0,
    //   insetAnimationCurve: Curves.easeInOut,
    //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    //   child: _child,
    // );
  }
}

class CloseIcon extends StatelessWidget {
  const CloseIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 16.0),
          child: Icon(
            Icons.close,
            size: 16.0,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }
}
