import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/demo_try_paginateddatatable/internal_widget.dart';
import 'package:web_tut/demo_try_paginateddatatable/mypaginated_datatable.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/has_import_provider.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_tut/screens/advanced_datatable/adv_home.dart';
import 'package:web_tut/screens/component/csv_import_button.dart';
import 'package:web_tut/utils/constants.dart';

class StudnumbersScreen extends StatefulWidget {
  // List<Student> students;
  StudnumbersScreen({
    Key key,
    // this.students
  }) : super(key: key);
  @override
  State<StudnumbersScreen> createState() => _StudnumbersScreenState();
}

class _StudnumbersScreenState extends State<StudnumbersScreen> {
  final studnumCtrl = TextEditingController();
  final lastnameCtrl = TextEditingController();
  final minitialCtrl = TextEditingController();
  final firstnameCtrl = TextEditingController();
  final courseCtrl = TextEditingController();
  final yearsecCtrl = TextEditingController();
  final collegeCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  //
  Uint8List _uploadedCsv = Uint8List.fromList([]);
  String _option1Text;
  ScrollController studScreen = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  _startFilePicker() async {
    // InputElement uploadInput = InputElement();
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            _uploadedCsv = const Base64Decoder().convert(
                reader.result.toString().replaceAll(' ', '').split(",").last);
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            _option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsDataUrl(file);
        // File f = File(files, files[0].name);
        // reader.readAsText(file);
        context.read<HasImportProvider>().changeHasImport = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final studData = utf8.decode(_uploadedCsv).replaceAll('\n', ',').split(",");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          MyPaginatedDataTable(),
          Container(
            margin: (() {
              //large
              if (size.height > 770) {
                if (size.width > 1400) {
                  return EdgeInsets.only(top: size.height / 1.2);
                }
                if (size.width > 670) {
                  return EdgeInsets.only(top: size.height / 1.2);
                } else {
                  return EdgeInsets.only(top: size.height / 1.2);
                }
              }
              //mid
              if (size.height > 670) {
                if (size.width > 1400) {
                  return EdgeInsets.only(top: size.height / 1.2);
                }
                if (size.width > 670) {
                  return EdgeInsets.only(top: size.height / 1.2);
                } else {
                  return EdgeInsets.only(top: size.height / 1.2);
                }
              }
              //small
              else {
                if (size.width > 1400) {
                  return EdgeInsets.only(top: size.height / 1.2);
                }
                if (size.width > 670) {
                  return EdgeInsets.only(top: size.height / 1.2);
                } else {
                  return EdgeInsets.only(top: size.height / 1.2);
                }
              }
            }()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GFButton(
                  onPressed: () {
                    StudentProvider studentProvider = StudentProvider();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          // backgroundColor: Colors.blue,
                          contentPadding: EdgeInsets.zero,
                          titlePadding: const EdgeInsets.only(top: 12),
                          elevation: 15,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            side: BorderSide(color: Colors.blue, width: 4),
                          ),
                          title: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 18),
                              child: Text(
                                "Add Student",
                                style: TextStyle(
                                    // color: Colors.white,
                                    ),
                              ),
                            ),
                          ),

                          content: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(21.0),
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
                                    onChanged: (value) => studentProvider
                                        .changeStudentNumber = value,
                                    controller: studnumCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                    onChanged: (value) =>
                                        studentProvider.changeFirstName = value,
                                    controller: firstnameCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                    onChanged: (value) =>
                                        studentProvider.changeMInitial = value,
                                    controller: minitialCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                    onChanged: (value) =>
                                        studentProvider.changeLastName = value,
                                    controller: lastnameCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                    onChanged: (value) =>
                                        studentProvider.changeEmail = value,
                                    controller: emailCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                    onChanged: (value) =>
                                        studentProvider.changeCourse = value,
                                    controller: courseCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                    onChanged: (value) =>
                                        studentProvider.changeYearLevel = value,
                                    controller: yearsecCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) =>
                                        studentProvider.changeSection = value,
                                    controller: yearsecCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Text(
                                    'College',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  TextFormField(
                                    onChanged: (value) =>
                                        studentProvider.changeCollege = value,
                                    controller: collegeCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            GFButton(
                              onPressed: () async {
                                String studentnumber =
                                    studentProvider.studentNumber;
                                String lastname = studentProvider.lastName;
                                String minitial = studentProvider.mInitial;
                                String firstname = studentProvider.firstName;
                                String course = studentProvider.course;
                                String yearlevel = studentProvider.yearLevel;
                                String section = studentProvider.section;
                                String college = studentProvider.college;
                                String email = studentProvider.email;

                                if ((studentnumber != null &&
                                        studentnumber != '') &&
                                    (lastname != null && lastname != '') &&
                                    (minitial != null && minitial != '') &&
                                    (firstname != null && firstname != '') &&
                                    (course != null && course != '') &&
                                    (yearlevel != null &&
                                        yearlevel.toString() != '') &&
                                    (section != null &&
                                        section.toString() != '') &&
                                    (college != null && college != '') &&
                                    (email != null && email != '')) {
                                  await studentProvider.saveStudent();
                                  Navigator.of(context).pop();
                                  const SnackBar(
                                    content: Text('Successfully Added'),
                                  );
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
                              text: 'Add',
                            ),
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
                  },
                  shape: GFButtonShape.pills,
                  elevation: 10,
                  child: const Text("Add Student Number"),
                ),
                context.watch<HasImportProvider>().hasImport
                    ? SingleChildScrollView(
                        controller: studScreen,
                        reverse: true,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: size.height / 90,
                            left: size.width / 50,
                            bottom: 10,
                          ),
                          child: CsvImportButton(
                              uploadedCsv: _uploadedCsv, studData: studData),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: (() {
          //large
          if (size.height > 770) {
            if (size.width > 1400) {
              return EdgeInsets.only(right: size.width / 1.25);
            }
            if (size.width > 670) {
              return EdgeInsets.only(right: size.width / 1.33);
            } else {
              return EdgeInsets.only(right: size.width / 1.5);
            }
          }
          //mid
          if (size.height > 670) {
            if (size.width > 1400) {
              return EdgeInsets.only(right: size.width / 1.25);
            }
            if (size.width > 670) {
              return EdgeInsets.only(right: size.width / 1.33);
            } else {
              return EdgeInsets.only(right: size.width / 1.5);
            }
          }
          //small
          else {
            if (size.width > 1400) {
              return EdgeInsets.only(right: size.width / 1.25);
            }
            if (size.width > 670) {
              return EdgeInsets.only(right: size.width / 1.33);
            } else {
              return EdgeInsets.only(right: size.width / 1.5);
            }
          }
        }()),
        //largest screen/full
        // size.height > 770 && size.width > 770
        //     ? EdgeInsets.only(right: size.width / 1.25)
        //     :
        //     size.height > 670 && size.width > 1540
        //         ? EdgeInsets.only(right: size.width / 1.3)
        //         : EdgeInsets.only(right: size.width / 1.5),
        child: FloatingActionButton(
          onPressed: () {
            _startFilePicker();
          },
          backgroundColor: Colors.green,
          child: Image.asset('assets/images/ic_import-csv-24.png'),
        ),
      ),
    );
  }
}
