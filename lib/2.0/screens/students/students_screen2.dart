import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/screens/dashboard/components/header.dart';
import 'package:web_tut/2.0/screens/dashboard/components/my_fields.dart';
import 'package:web_tut/2.0/screens/students/components/collegecoursesection_dropdown.dart';
import 'package:web_tut/2.0/screens/students/components/csv_import_button2.dart';
import 'package:web_tut/2.0/screens/students/components/paginated_datatable2_desert.dart';
import 'package:web_tut/2.0/screens/students/components/selection_provider.dart';
import 'package:web_tut/2.0/screens/students/components/sfdata_search.dart';
import 'package:web_tut/2.0/screens/students/components/sfdata_search_provider.dart';
import 'package:web_tut/2.0/screens/students/components/students_details.dart';
import 'package:web_tut/2.0/screens/students/components/students_screen_header.dart';
import 'package:web_tut/2.0/screens/students/components/syncfusion_dtgrid.dart';
import 'package:web_tut/2.0/screens/students/components/update_collegecoursesectiondropdown.dart';
import 'package:web_tut/demo_try_paginateddatatable/datatable_source.dart';
import 'package:web_tut/demo_try_paginateddatatable/mypaginated_datatable.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/has_import_provider.dart';
import 'package:web_tut/providers/request_provider.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/utils/constants.dart';

import '../../constants.dart';
import '../../responsive.dart';

double _dataPagerHeight = 60.0;
int _rowsPerPage = 15;
// List<Student> _paginatedStudents = [];
String _option1Text;
final DataGridController _dataGridController = DataGridController();
Uint8List _uploadedCsv = Uint8List.fromList([]);

class StudentsScreen2 extends StatefulWidget {
  @override
  State<StudentsScreen2> createState() => _StudentsScreen2State();
}

class _StudentsScreen2State extends State<StudentsScreen2>
    with AutomaticKeepAliveClientMixin<StudentsScreen2> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<Student>> _streamMembers;
  Stream<List<Thread>> _streamThreads;
  Stream<List<Student>> _streamAllStudents;
  // Stream<List<Student>> _streamSearchedStudents;
  StudentDataSource2 studentDataSource2;
  // Define the global keys
  final _formKeyFname = GlobalKey<FormState>();
  final _formKeyMinitial = GlobalKey<FormState>();
  final _formKeyLname = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyStudentnumber = GlobalKey<FormState>();
  //for update global keys
  final _formKeyUpdFname = GlobalKey<FormState>();
  final _formKeyUpdMinitial = GlobalKey<FormState>();
  final _formKeyUpdLname = GlobalKey<FormState>();
  // TextEditingController _aboutCtrl;

  @override
  void initState() {
    _streamMembers = firestoreService.getUsers();
    _streamThreads = firestoreService.getThreads();
    _streamAllStudents = firestoreService.getStudents();
    setState(() {
      _isVisited = true;
    });
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
            print(_option1Text);
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
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: StreamBuilder<List<Student>>(
              stream: context.watch<SFDataSearchProvider>().searchText == ''
                  ? _streamAllStudents
                  : context.read<SFDataSearchProvider>().searchedStudents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  studentDataSource2 = StudentDataSource2(
                    studentData: snapshot.data,
                  );
                  return LayoutBuilder(
                    builder: (context, constraint) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              if (!Responsive.isDesktop(context))
                                IconButton(
                                    icon: const Icon(Icons.menu),
                                    onPressed: () {
                                      context.read<MenuController>().isClicked =
                                          true;
                                      context
                                                  .read<MenuController>()
                                                  .isClicked ==
                                              true
                                          ? Scaffold.of(context).openDrawer()
                                          : null;
                                    }
                                    // context.read<MenuController>().controlMenu,
                                    // context.read<MenuController>().isClicked = true;
                                    ),
                              if (!Responsive.isMobile(context))
                                Text(
                                  "Students",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              if (!Responsive.isMobile(context))
                                Spacer(
                                    flex:
                                        Responsive.isDesktop(context) ? 2 : 1),
                              Expanded(
                                child:
                                    // context
                                    //         .watch<SelectionProvider>()
                                    //         .haveSelections
                                    context.watch<StudentProvider>().ids.isEmpty
                                        ? const SFDataSearchField()
                                        : Container(),
                              ),
                              // const StudentsScreenHeader(),
                              SizedBox(
                                width: size.width * .03,
                              ),
                              context.watch<StudentProvider>().ids.isEmpty
                                  ? GFButton(
                                      onPressed: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Stack(
                                                children: [
                                                  SingleChildScrollView(
                                                    child: AlertDialog(
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Container(
                                                          width:
                                                              double.maxFinite,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Form(
                                                                            key:
                                                                                _formKeyFname,
                                                                            child:
                                                                                TextFormField(
                                                                              onChanged: (value) => context.read<StudentProvider>().changeFirstName = value,
                                                                              decoration: const InputDecoration(
                                                                                labelText: 'First Name',
                                                                              ),
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Please enter first name';
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
                                                                                _formKeyMinitial,
                                                                            child:
                                                                                TextFormField(
                                                                              onChanged: (value) => context.read<StudentProvider>().changeMInitial = value,
                                                                              decoration: const InputDecoration(
                                                                                labelText: 'Middle Initial',
                                                                              ),
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Please enter middle initial';
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
                                                                                _formKeyLname,
                                                                            child:
                                                                                TextFormField(
                                                                              onChanged: (value) => context.read<StudentProvider>().changeLastName = value,
                                                                              decoration: const InputDecoration(
                                                                                labelText: 'Last Name',
                                                                              ),
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Please enter last name';
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
                                                                                _formKeyEmail,
                                                                            child:
                                                                                TextFormField(
                                                                              keyboardType: TextInputType.emailAddress,
                                                                              onChanged: (value) => context.read<StudentProvider>().changeEmail = value,
                                                                              decoration: const InputDecoration(
                                                                                labelText: 'Email',
                                                                              ),
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Please enter email';
                                                                                }
                                                                                if (!value.contains('@')) {
                                                                                  return 'Bad email format';
                                                                                } else {
                                                                                  return null;
                                                                                }
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 12,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Form(
                                                                            key:
                                                                                _formKeyStudentnumber,
                                                                            child:
                                                                                TextFormField(
                                                                              onChanged: (value) => context.read<StudentProvider>().changeStudentNumber = value,
                                                                              maxLength: 10,
                                                                              keyboardType: TextInputType.number,
                                                                              decoration: const InputDecoration(
                                                                                labelText: 'Student Number',
                                                                              ),
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Please enter student number';
                                                                                }
                                                                                if (value.length < 10) {
                                                                                  return 'Invalid student number';
                                                                                } else {
                                                                                  return null;
                                                                                }
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const CollegeCourseSectionDropDown(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              //add button
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  GFButton(
                                                                    onPressed:
                                                                        () async {
                                                                      if ((_formKeyFname.currentState.validate() && _formKeyMinitial.currentState.validate()) &&
                                                                          (_formKeyLname.currentState.validate() &&
                                                                              _formKeyEmail.currentState
                                                                                  .validate()) &&
                                                                          _formKeyStudentnumber
                                                                              .currentState
                                                                              .validate()) {
                                                                        await context
                                                                            .read<StudentProvider>()
                                                                            .saveStudent();
                                                                        Future.delayed(
                                                                            const Duration(seconds: 1),
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        });
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          const SnackBar(
                                                                              content: Text('Successfully added.')),
                                                                        );
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
                                                                          .changeActivityTitle = 'Added a student';
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
                                                                    },
                                                                    text: 'Add',
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
                                                    right: size.width * .02,
                                                    top: 3,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const CircleAvatar(
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                        ),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      elevation: 9,
                                      child: Row(
                                        children: const [
                                          Icon(Icons.add),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text("Add Student"),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                width: size.width * .03,
                              ),
                              context.watch<StudentProvider>().ids.isNotEmpty
                                  ? Container()
                                  : context.watch<HasImportProvider>().hasImport
                                      ? CsvImportButton2(
                                          uploadedCsv: _uploadedCsv,
                                          studData: studData,
                                        )
                                      : GFButton(
                                          onPressed: () {
                                            _startFilePicker();
                                          },
                                          elevation: 9,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/ic_import-csv-24.png',
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              const Text("Select CSV File"),
                                            ],
                                          ),
                                        ),
                              SizedBox(
                                width: size.width * .03,
                              ),
                              context.watch<StudentProvider>().ids.isEmpty
                                  ? Container()
                                  : Row(
                                      children: [
                                        GFButton(
                                          onPressed: () async {
                                            List deleteIDs = context
                                                .read<StudentProvider>()
                                                .ids;
                                            for (var i = 0;
                                                i < deleteIDs.length;
                                                i++) {
                                              await context
                                                  .read<StudentProvider>()
                                                  .removeStudent(
                                                      deleteIDs[i].toString());
                                              //show snackbar
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Successfully deleted.')),
                                              );
                                              context
                                                  .read<StudentProvider>()
                                                  .ids = [];
                                              //create activity
                                              String myName = await context
                                                  .read<LocalDataProvider>()
                                                  .getLocalAdminName();
                                              context
                                                      .read<AdminActivityProvider>()
                                                      .changeActivityTitle =
                                                  'Removed a student';
                                              context
                                                  .read<AdminActivityProvider>()
                                                  .changeName = myName;
                                              context
                                                  .read<AdminActivityProvider>()
                                                  .changeDate = DateTime.now();
                                              await context
                                                  .read<AdminActivityProvider>()
                                                  .addActivity();
                                            }
                                          },
                                          elevation: 9,
                                          color: Colors.red,
                                          child: Row(
                                            children: const [
                                              Icon(Icons.delete),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Text("Delete"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * .03,
                                        ),
                                        context
                                                    .watch<StudentProvider>()
                                                    .ids
                                                    .length <
                                                2
                                            ? GFButton(
                                                onPressed: () {
                                                  //edit student details
                                                  //show snackbar
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   const SnackBar(
                                                  //       content: Text(
                                                  //           'Successfully updated.')),
                                                  // );
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Stack(
                                                          children: [
                                                            SingleChildScrollView(
                                                              child:
                                                                  AlertDialog(
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .maxFinite,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Text(
                                                                                          'CURRENT DETAILS ',
                                                                                          style: TextStyle(
                                                                                            color: kMiddleColor,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  //first name
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 15,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: const Text(
                                                                                      'First Name: ',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white70,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 6,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: Text(context.read<StudentProvider>().tapped[2]),
                                                                                  ),
                                                                                  //middle initial
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 15,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: const Text(
                                                                                      'Middle Initial: ',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white70,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 6,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: Text(context.read<StudentProvider>().tapped[3]),
                                                                                  ),
                                                                                  //last name
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 15,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: const Text(
                                                                                      'Last Name: ',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white70,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 6,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: Text(context.read<StudentProvider>().tapped[4]),
                                                                                  ),
                                                                                  //college
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 15,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: const Text(
                                                                                      'College: ',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white70,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 6,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: Text(context.read<StudentProvider>().tapped[8]),
                                                                                  ),
                                                                                  //course
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 15,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: const Text(
                                                                                      'Course: ',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white70,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 6,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: Text(context.read<StudentProvider>().tapped[5]),
                                                                                  ),
                                                                                  //year level
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 15,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: const Text(
                                                                                      'Year Level: ',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white70,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 6,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: Text(context.read<StudentProvider>().tapped[6]),
                                                                                  ),
                                                                                  //section
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 15,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: const Text(
                                                                                      'Section: ',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white70,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: size.width / 6,
                                                                                      right: 8.0,
                                                                                      top: 8.0,
                                                                                      bottom: 8.0,
                                                                                    ),
                                                                                    child: Text(context.read<StudentProvider>().tapped[7]),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 12,
                                                                            ),
                                                                            Expanded(
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Form(
                                                                                      key: _formKeyUpdFname,
                                                                                      child: TextFormField(
                                                                                        initialValue: context.read<StudentProvider>().tapped[2],
                                                                                        onChanged: (value) => context.read<StudentProvider>().updFirstName = value,
                                                                                        decoration: const InputDecoration(
                                                                                          labelText: 'First Name',
                                                                                        ),
                                                                                        validator: (value) {
                                                                                          if (value == null || value.isEmpty) {
                                                                                            return 'Please enter first name';
                                                                                          } else {
                                                                                            return null;
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Form(
                                                                                      key: _formKeyUpdMinitial,
                                                                                      child: TextFormField(
                                                                                        initialValue: context.read<StudentProvider>().tapped[3],
                                                                                        onChanged: (value) => context.read<StudentProvider>().updMInitial = value,
                                                                                        decoration: const InputDecoration(
                                                                                          labelText: 'Middle Initial',
                                                                                        ),
                                                                                        validator: (value) {
                                                                                          if (value == null || value.isEmpty) {
                                                                                            return 'Please enter middle initial';
                                                                                          } else {
                                                                                            return null;
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Form(
                                                                                      key: _formKeyUpdLname,
                                                                                      child: TextFormField(
                                                                                        initialValue: context.read<StudentProvider>().tapped[4],
                                                                                        onChanged: (value) => context.read<StudentProvider>().updLastName = value,
                                                                                        decoration: const InputDecoration(
                                                                                          labelText: 'Last Name',
                                                                                        ),
                                                                                        validator: (value) {
                                                                                          if (value == null || value.isEmpty) {
                                                                                            return 'Please enter last name';
                                                                                          } else {
                                                                                            return null;
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const UpdateCollegeCourseSectionDropDown(),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        //add button
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            GFButton(
                                                                              onPressed: () async {
                                                                                if ((_formKeyUpdFname.currentState.validate() && _formKeyUpdMinitial.currentState.validate()) && _formKeyUpdLname.currentState.validate()) {
                                                                                  await context.read<StudentProvider>().editStudentDetails();
                                                                                  // print(context.read<StudentProvider>().tapped);
                                                                                  Future.delayed(const Duration(seconds: 1), () {
                                                                                    Navigator.of(context).pop();
                                                                                  });
                                                                                  context.read<StudentProvider>().ids = [];
                                                                                  Future.delayed(const Duration(seconds: 1), () {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      const SnackBar(content: Text('Successfully updated.')),
                                                                                    );
                                                                                  });
                                                                                }
                                                                                //create activity
                                                                                String myName = await context.read<LocalDataProvider>().getLocalAdminName();
                                                                                context.read<AdminActivityProvider>().changeActivityTitle = 'Updated student details';
                                                                                context.read<AdminActivityProvider>().changeName = myName;
                                                                                context.read<AdminActivityProvider>().changeDate = DateTime.now();
                                                                                await context.read<AdminActivityProvider>().addActivity();
                                                                              },
                                                                              text: 'Save',
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
                                                              right:
                                                                  size.width *
                                                                      .02,
                                                              top: 3,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const CircleAvatar(
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                                elevation: 9,
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.edit),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text("Edit"),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                              // (context
                              //             .watch<StudentProvider>()
                              //             .ids
                              //             .isNotEmpty &&
                              //         context
                              //                 .watch<StudentProvider>()
                              //                 .ids
                              //                 .length ==
                              //             1)
                              //     ? Container()
                              //     : GFButton(
                              //         onPressed: () {
                              //           //edit student details
                              //           //show snackbar
                              //           ScaffoldMessenger.of(context)
                              //               .showSnackBar(
                              //             const SnackBar(
                              //                 content: Text(
                              //                     'Successfully updated.')),
                              //           );
                              //         },
                              //         elevation: 9,
                              //         child: Row(
                              //           children: const [
                              //             Icon(Icons.edit),
                              //             SizedBox(
                              //               width: 12,
                              //             ),
                              //             Text("Edit"),
                              //           ],
                              //         ),
                              //       ),
                            ],
                          ),
                          SizedBox(
                            height:
                                (constraint.maxHeight / 1.1) - _dataPagerHeight,
                            width: constraint.maxWidth,
                            child: _buildDataGrid(constraint),
                          ),
                          // Container(
                          //   child: const Center(
                          //     child: Text(
                          //       'Working. Temporarily disabled\nto save data (data table)',
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: SfDataPager(
                              delegate: studentDataSource2,
                              pageCount: context
                                          .read<SFDataSearchProvider>()
                                          .searchText ==
                                      ''
                                  ? (snapshot.data.length / _rowsPerPage)
                                      .round()
                                      .toDouble()
                                  : 1,
                              direction: Axis.horizontal,
                            ),
                          ),
                          // Container(
                          //   child: const Center(
                          //     child: Text(
                          //       'Working. Temporarily disabled\nto save data (pagination)',
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            )),
      ),
    );
  }

  Widget _buildDataGrid(BoxConstraints constraint) {
    Size size = MediaQuery.of(context).size;
    List ids = [];
    List<DataGridCell<dynamic>> selectedCells = [];
    List tapped = [];

    return SfDataGrid(
      allowPullToRefresh: true,
      onSelectionChanged: (addedRows, removedRows) {
        addedRows = _dataGridController.selectedRows;
        addedRows.forEach((row) {
          selectedCells = row.getCells();
          selectedCells.forEach((cell) {
            if (cell.columnName == 'id') {
              ids.add(cell.value);
            }
          });

          selectedCells.forEach((cell) {
            tapped.add(cell.value.toString());
          });
        });
        context.read<StudentProvider>().changeTapped = tapped;
        // context.read<StudentProvider>().changeUpdStudentDetails(
        //       updstudentnumber: tapped[0], //studnumber
        //       updfirstname: tapped[2], //fname
        //       updminitial: tapped[3], //initial
        //       updlastname: tapped[4], //lname
        //       updcollege: tapped[8], //college
        //       updcourse: tapped[5], //course
        //       updyearlvl: tapped[6], //year
        //       updsection: tapped[7], //section
        //     );
        context.read<StudentProvider>().ids = ids;
        print(context.read<StudentProvider>().ids);
        print(context.read<StudentProvider>().tapped);
      },
      onSelectionChanging: (addedRows, removedRows) {
        context.read<SelectionProvider>().haveSelections = true;
        return true;
      },
      controller: _dataGridController,
      showCheckboxColumn: true,
      selectionMode: SelectionMode.multiple,
      allowSorting: true,
      source: studentDataSource2,
      columnWidthMode: ColumnWidthMode.fill,
      rowHeight: size.height * .1,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'id',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('ID'),
          ),
        ),
        GridColumn(
          columnName: 'photo',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Photo'),
          ),
        ),
        GridColumn(
          columnName: 'firstName',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('First Name'),
          ),
        ),
        GridColumn(
          columnName: 'middleInitial',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Middle Initial'),
          ),
        ),
        GridColumn(
          columnName: 'lastName',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Last Name'),
          ),
        ),
        GridColumn(
          columnName: 'course',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Course'),
          ),
        ),
        GridColumn(
          columnName: 'yearLevel',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Year Level'),
          ),
        ),
        GridColumn(
          columnName: 'section',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Section'),
          ),
        ),
        GridColumn(
          columnName: 'college',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('College'),
          ),
        ),
        GridColumn(
          columnName: 'email',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Email'),
          ),
        ),
      ],
    );
  }
}

class StudentDataSource2 extends DataGridSource {
  /// Creates the employee data source class with required details.
  StudentDataSource2({@required List<Student> studentData}) {
    _students = studentData;
    _paginatedStudents =
        //studentData;
        _students.getRange(0, studentData.length).toList(growable: false);
    buildPaginatedDataGridRows();
    notifyListeners();
  }
  List<Student> _students = [];
  List<Student> _paginatedStudents = [];
  List<DataGridRow> _studentDataGridRows = [];

  @override
  List<DataGridRow> get rows => _studentDataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'photo') {
        return Container(
          child: dataGridCell.value == ''
              ? ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  child: Image.asset('assets/images/user-no-image.png'))
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(60),
                    ),
                    child: Image.network(
                      dataGridCell.value,
                      fit: BoxFit.cover,
                      height: 12,
                      width: 12,
                    ),
                  ),
                ),
        );
      } else {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(dataGridCell.value.toString()),
        );
      }
    }).toList());
  }

  // @override
  // Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
  //   int startIndex = newPageIndex * _rowsPerPage;
  //   int endIndex = startIndex + _rowsPerPage;
  //   if (startIndex < _students.length && endIndex <= _students.length) {
  //     _paginatedStudents =
  //         _students.getRange(startIndex, endIndex).toList(growable: false);
  //     buildPaginatedDataGridRows();
  //     notifyListeners();
  //     return true;
  //   } else {
  //     _paginatedStudents = [];
  //   }
  //   return true;
  // }

  void buildPaginatedDataGridRows() {
    _studentDataGridRows = _paginatedStudents.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: int.parse(e.studentNumber)),
        DataGridCell<String>(columnName: 'photo', value: e.photo),
        DataGridCell<String>(columnName: 'firstName', value: e.firstName),
        DataGridCell<String>(columnName: 'middleInitial', value: e.mInitial),
        DataGridCell<String>(columnName: 'lastName', value: e.lastName),
        DataGridCell<String>(columnName: 'course', value: e.course),
        DataGridCell<int>(columnName: 'yearLevel', value: e.yearLvl),
        DataGridCell<int>(columnName: 'section', value: e.section),
        DataGridCell<String>(columnName: 'college', value: e.college),
        DataGridCell<String>(columnName: 'email', value: e.email),
      ]);
    }).toList(growable: false);
  }
}
