import 'dart:typed_data';

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/providers/userdata_notifier.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';

final studnumCtrl = TextEditingController();
final lastnameCtrl = TextEditingController();
final minitialCtrl = TextEditingController();
final firstnameCtrl = TextEditingController();
final courseCtrl = TextEditingController();
final collegeCtrl = TextEditingController();
final emailCtrl = TextEditingController();
final yearsecCtrl = TextEditingController();

class AdvHome extends StatefulWidget {
  List<Student> students;
  AdvHome({Key key, this.students}) : super(key: key);

  @override
  _AdvHomeState createState() => _AdvHomeState();
}

class _AdvHomeState extends State<AdvHome> {
  // List<Student> students;
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  // var sortIndex = 0;
  // var sortAsc = true;
  final searchController = TextEditingController();
  ScrollController advScroll = ScrollController();

  //==================

  @override
  void initState() {
    super.initState();
    searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final _src = AdvancedSource(widget.students, context);
    UserDataNotifier _provider = context.read<UserDataNotifier>();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Advanced Table'),
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          controller: advScroll,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: 'Search by company',
                        ),
                        onSubmitted: (vlaue) {
                          _src.filterServerSide(searchController.text);
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        searchController.text = '';
                      });
                      _src.filterServerSide(searchController.text);
                    },
                    icon: Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: () =>
                        _src.filterServerSide(searchController.text),
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              AdvancedPaginatedDataTable(
                header: Text('Students'),

                addEmptyRows: false,
                source: _src,
                showFirstLastButtons: true,
                rowsPerPage: rowsPerPage,
                availableRowsPerPage: const [10, 20, 30, 50],
                onRowsPerPageChanged: (newRowsPerPage) {
                  if (newRowsPerPage != null) {
                    setState(() {
                      rowsPerPage = newRowsPerPage;
                    });
                  }
                },
                columns: [
                  DataColumn(
                    label: const Text('Student Number ↑↓'),
                    tooltip: 'Student Number',
                    onSort: (colIndex, asc) {
                      if (asc == _provider.sortAscending) {
                        asc = false;
                        // setState(() {
                        _sort((student) => student.studentNumber, colIndex, asc,
                            _src, _provider);
                        // });
                      } else {
                        asc = true;
                        // setState(() {
                        _sort((student) => student.studentNumber, colIndex, asc,
                            _src, _provider);
                        // });
                      }
                    },
                  ),
                  DataColumn(
                    label: const Text('First Name ↑↓'),
                    tooltip: 'First Name',
                    onSort: (colIndex, asc) {
                      if (asc != _provider.sortAscending) {
                        _sort((student) => student.firstName, colIndex, asc,
                            _src, _provider);
                      } else {
                        asc = false;
                        _sort((student) => student.firstName, colIndex, asc,
                            _src, _provider);
                      }
                    },
                  ),
                  DataColumn(
                    label: const Text('Middle Initial ↑↓'),
                    tooltip: 'Middle Initial',
                    onSort: (colIndex, asc) {
                      if (asc != _provider.sortAscending) {
                        _sort((student) => student.mInitial, colIndex, asc,
                            _src, _provider);
                      } else {
                        asc = false;
                        _sort((student) => student.mInitial, colIndex, asc,
                            _src, _provider);
                      }
                    },
                  ),
                  DataColumn(
                    label: const Text('Last Name ↑↓'),
                    tooltip: 'Last Name',
                    onSort: (colIndex, asc) {
                      if (asc != _provider.sortAscending) {
                        _sort((student) => student.lastName, colIndex, asc,
                            _src, _provider);
                      } else {
                        asc = false;
                        _sort((student) => student.lastName, colIndex, asc,
                            _src, _provider);
                      }
                    },
                  ),
                  DataColumn(
                    label: const Text('Course ↑↓'),
                    tooltip: 'Course',
                    onSort: (colIndex, asc) {
                      if (asc != _provider.sortAscending) {
                        _sort((student) => student.course, colIndex, asc, _src,
                            _provider);
                      } else {
                        asc = false;
                        _sort((student) => student.course, colIndex, asc, _src,
                            _provider);
                      }
                    },
                  ),
                  DataColumn(
                    label: const Text('Year Level ↑↓'),
                    tooltip: 'Year Level',
                    onSort: (colIndex, asc) {
                      if (asc != _provider.sortAscending) {
                        _sort((student) => student.yearLvl, colIndex, asc, _src,
                            _provider);
                      } else {
                        asc = false;
                        _sort((student) => student.yearLvl, colIndex, asc, _src,
                            _provider);
                      }
                    },
                  ),
                  DataColumn(
                    label: const Text('Section ↑↓'),
                    tooltip: 'Section',
                    onSort: (colIndex, asc) {
                      if (asc != _provider.sortAscending) {
                        _sort((student) => student.section, colIndex, asc, _src,
                            _provider);
                      } else {
                        asc = false;
                        _sort((student) => student.section, colIndex, asc, _src,
                            _provider);
                      }
                    },
                  ),
                  DataColumn(
                    label: const Text('Email ↑↓'),
                    tooltip: 'Email',
                    onSort: (colIndex, asc) {
                      if (asc != _provider.sortAscending) {
                        _sort((student) => student.email, colIndex, asc, _src,
                            _provider);
                      } else {
                        asc = false;
                        _sort((student) => student.email, colIndex, asc, _src,
                            _provider);
                      }
                    },
                  ),
                  DataColumn(
                    label: const Text('College ↑↓'),
                    tooltip: 'College',
                    onSort: (colIndex, asc) {
                      if (asc != _provider.sortAscending) {
                        _sort((student) => student.college, colIndex, asc, _src,
                            _provider);
                      } else {
                        asc = false;
                        _sort((student) => student.college, colIndex, asc, _src,
                            _provider);
                      }
                    },
                  ),
                  // const DataColumn(
                  // label: Text('Actions'),
                  // onSort: (colIndex, asc) {
                  //   if (asc != _provider.sortAscending) {
                  //     _sort((student) => student.college, colIndex, asc,
                  //         _src, _provider);
                  //   } else {
                  //     asc = false;
                  //     _sort((student) => student.college, colIndex, asc,
                  //         _src, _provider);
                  //   }
                  // },
                  // ),
                ],
                //Optianl override to support custom data row text / translation
                getFooterRowText:
                    (startRow, pageSize, totalFilter, totalRowsWithoutFilter) {
                  final localizations = MaterialLocalizations.of(context);
                  var amountText = localizations.pageRowsInfoTitle(
                    startRow,
                    pageSize,
                    totalFilter ?? totalRowsWithoutFilter,
                    false,
                  );

                  if (totalFilter != null) {
                    //Filtered data source show addtional information
                    amountText += ' filtered from ($totalRowsWithoutFilter)';
                  }

                  return amountText;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sort<T>(
    Comparable<T> Function(Student student) getField,
    int colIndex,
    bool asc,
    AdvancedSource _src,
    UserDataNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.changeSortAscending = asc;
    _provider.changeSortColumnIndex = colIndex;
  }
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class AdvancedSource extends AdvancedDataTableSource<Student> {
  BuildContext context;
  final List<Student> students;
  // final _formKey = GlobalKey<FormState>();
// ScrollController studScreen = ScrollController();

  AdvancedSource(this.students, this.context);
  //======================================
  List<String> selectedIds = [];
  String lastSearchTerm = '';

  @override
  DataRow getRow(int index) {
    final currentRowData = students[index];
    return DataRow.byIndex(cells: [
      DataCell(
        Text(currentRowData.studentNumber),
      ),
      DataCell(
        Text(currentRowData.firstName),
      ),
      DataCell(
        Text(currentRowData.mInitial),
      ),
      DataCell(
        Text(currentRowData.lastName),
      ),
      DataCell(
        Text(currentRowData.course),
      ),
      DataCell(
        Text(currentRowData.yearLvl.toString()),
      ),
      DataCell(Text(currentRowData.section.toString())),
      DataCell(
        Text(currentRowData.email),
      ),
      DataCell(
        Text(students[index].college),
      ),
      // DataCell(
      //   // Container()
      //   Row(
      //     children: [
      //       IconButton(
      //           onPressed: () {
      //             showEditDialog(
      //               students[index].studentNumber,
      //               students[index].lastName,
      //               students[index].mInitial,
      //               students[index].firstName,
      //               students[index].college,
      //               students[index].course,
      //               students[index].email,
      //               students[index].yearSec,
      //             );
      //           },
      //           icon: Icon(
      //             Icons.edit_rounded,
      //             color: kPrimaryColor,
      //           )),
      //       IconButton(
      //           onPressed: () {
      //             // showMyDialog();
      //             showDialog(
      //               context: context,
      //               barrierDismissible: false,
      //               builder: (BuildContext context) {
      //                 return AlertDialog(
      //                   // backgroundColor: Colors.blue,
      //                   elevation: 15,
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: const BorderRadius.all(
      //                       Radius.circular(6.0),
      //                     ),
      //                     side: BorderSide(color: Colors.red[700], width: 4),
      //                   ),
      //                   title: Row(
      //                     children: [
      //                       Icon(
      //                         Icons.warning,
      //                         color: Colors.red[700],
      //                       ),
      //                       const SizedBox(
      //                         width: 12,
      //                       ),
      //                       Text(
      //                         'Remove',
      //                         style: TextStyle(color: Colors.red[700]),
      //                       ),
      //                     ],
      //                   ),
      //                   content: SingleChildScrollView(
      //                     child: ListBody(
      //                       children: const <Widget>[
      //                         Text('You are going to remove a student'),
      //                         Text('Would you like to remove this student?'),
      //                       ],
      //                     ),
      //                   ),
      //                   actions: <Widget>[
      //                     TextButton(
      //                       child: const Text('Cancel'),
      //                       onPressed: () {
      //                         Navigator.of(context).pop();
      //                       },
      //                     ),
      //                     TextButton(
      //                       child: Text(
      //                         'Remove',
      //                         style: TextStyle(color: Colors.red[700]),
      //                       ),
      //                       onPressed: () {
      //                         context.read<StudentProvider>().removeStudent(
      //                             students[index].studentNumber);
      //                         Navigator.of(context).pop();
      //                         const SnackBar(
      //                           content: Text('Successfully Removed'),
      //                         );
      //                       },
      //                     ),
      //                   ],
      //                 );
      //               },
      //             );
      //           },
      //           icon: Icon(
      //             Icons.delete,
      //             color: Colors.red[700],
      //           )),
      //     ],
      //   ),
      // ),
    ], index: index);
  }

  @override
  int get selectedRowCount => 0;

  // @override
  // int get selectedRowCount => selectedIds.length;

  // ignore: avoid_positional_boolean_parameters
  // void selectedRow(String id, bool newSelectState) {
  //   if (selectedIds.contains(id)) {
  //     selectedIds.remove(id);
  //   } else {
  //     selectedIds.add(id);
  //   }
  //   notifyListeners();
  // }
  @override
  Future<RemoteDataSourceDetails<Student>> getNextPage(
      NextPageRequest pageRequest) async {
    return RemoteDataSourceDetails(
      students.length,
      students
          .skip(pageRequest.offset)
          .take(pageRequest.pageSize)
          .toList(), //again in a real world example you would only get the right amount of rows
      // filteredRows: students.length,
    );
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  //========================

  sort<T>(Comparable<T> Function(Student s) getField, bool ascending) {
    students.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  //============================
  showEditDialog(
    String studnumber,
    String lastname,
    String minitial,
    String firstname,
    String college,
    String course,
    String email,
    String yearsec,
  ) async {
    studnumCtrl.text = studnumber;
    lastnameCtrl.text = lastname;
    minitialCtrl.text = minitial;
    firstnameCtrl.text = firstname;
    collegeCtrl.text = college;
    courseCtrl.text = course;
    emailCtrl.text = email;
    yearsecCtrl.text = yearsec;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(12),
          titlePadding: const EdgeInsets.only(top: 0),
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(32.0),
            ),
            side: BorderSide(color: kPrimaryColor, width: 4),
          ),
          title: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              color: kPrimaryColor,
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 18, left: 18, bottom: 15),
              child: Text(
                "Add Student",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.9,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  Form(
                    child: Column(
                      children: [
                        // const Text('Student Number'),
                        TextFormField(
                          readOnly: true,
                          controller: studnumCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            labelText: 'Student Number',
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          onChanged: (String value) => context
                              .read<StudentProvider>()
                              .changeStudentNumber = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid input';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          controller: lastnameCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            labelText: 'Last Name',
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onChanged: (String value) => context
                              .read<StudentProvider>()
                              .changeLastName = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid input';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          controller: minitialCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            labelText: 'Middle Initial',
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onChanged: (String value) => context
                              .read<StudentProvider>()
                              .changeMInitial = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid input';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          controller: firstnameCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            labelText: 'First Name',
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onChanged: (String value) => context
                              .read<StudentProvider>()
                              .changeFirstName = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid input';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          controller: collegeCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            labelText: 'College',
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onChanged: (String value) => context
                              .read<StudentProvider>()
                              .changeCollege = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid input';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          controller: courseCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            labelText: 'Course',
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onChanged: (String value) => context
                              .read<StudentProvider>()
                              .changeCourse = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid input';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          controller: emailCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            labelText: 'Email',
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onChanged: (String value) => context
                              .read<StudentProvider>()
                              .changeEmail = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid input';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: yearsecCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            labelText: 'Year Level',
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onChanged: (String value) => context
                              .read<StudentProvider>()
                              .changeYearLevel = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid input';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: yearsecCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            labelText: 'Section',
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onChanged: (String value) => context
                              .read<StudentProvider>()
                              .changeSection = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid input';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GFButton(
                        onPressed: () {
                          // if (_formKey.currentState.validate()) {
                          //   context.read<StudentProvider>()..saveStudent();
                          //   Navigator.of(context, rootNavigator: true).pop();
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       duration: Duration(milliseconds: 500),
                          //       content: Text('Successfully added!'),
                          //     ),
                          //   );
                          // }
                          studnumCtrl.clear();
                          // studnameCtrl.clear();
                        },
                        child: const Text("Add"),
                      ),
                      GFButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          studnumCtrl.clear();
                          // studnameCtrl.clear();
                        },
                        color: Colors.red,
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              ),
              //body
            ),
          ),
        );
      },
    );
  }
}
