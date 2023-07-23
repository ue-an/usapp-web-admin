import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/colleges/components/selection_college_provider.dart';
import 'package:web_tut/2.0/screens/students/components/selection_provider.dart';
import 'package:web_tut/models/college.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/college_provider.dart';
import 'package:web_tut/providers/course_provider.dart';
import 'package:web_tut/services/firestore_service.dart';

double _dataPagerHeight = 60.0;
int _rowsPerPage = 15;
final DataGridController _dataGridController = DataGridController();

class CollegesScreen2 extends StatefulWidget {
  const CollegesScreen2({Key key}) : super(key: key);

  @override
  State<CollegesScreen2> createState() => _CollegesScreen2State();
}

class _CollegesScreen2State extends State<CollegesScreen2>
    with AutomaticKeepAliveClientMixin<CollegesScreen2> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<College>> _streamCollege;
  CollegeDataSource2 collegeDataSource2;
  final _formKeyCampus = GlobalKey<FormState>();
  final _formKeyCollege = GlobalKey<FormState>();
  final _formKeyCourse = GlobalKey<FormState>();
  final _formKeyNewCourse = GlobalKey<FormState>();
  final _formKeyYears = GlobalKey<FormState>();
  final _formKeySections = GlobalKey<FormState>();
  List<int> numbers = [2, 3, 4, 5, 6, 7, 8, 9];
  @override
  void initState() {
    _streamCollege = firestoreService.getColleges();
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: StreamBuilder<List<College>>(
          stream: _streamCollege,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              collegeDataSource2 = CollegeDataSource2(
                collegeData: snapshot.data,
              );
              return LayoutBuilder(
                builder: (context, constraints) {
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
                                  context.read<MenuController>().isClicked ==
                                          true
                                      ? Scaffold.of(context).openDrawer()
                                      : null;
                                }),
                          if (!Responsive.isMobile(context))
                            Text(
                              "List of Colleges",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          if (!Responsive.isMobile(context))
                            Spacer(
                              flex: Responsive.isDesktop(context) ? 2 : 1,
                            ),
                          SizedBox(
                            width: size.width * .03,
                          ),
                          context
                                  .watch<SelectionCollegeProvider>()
                                  .haveSelections
                              ? Container()
                              : GFButton(
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
                                                      width: double.maxFinite,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Form(
                                                                        key:
                                                                            _formKeyCampus,
                                                                        child:
                                                                            TextFormField(
                                                                          onChanged: (value) => context
                                                                              .read<CollegeProvider>()
                                                                              .changeCampus = value,
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'Campus'),
                                                                          validator:
                                                                              (value) {
                                                                            if (value == null ||
                                                                                value.isEmpty) {
                                                                              return 'Please enter campus';
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Form(
                                                                        key:
                                                                            _formKeyCollege,
                                                                        child:
                                                                            TextFormField(
                                                                          onChanged:
                                                                              (value) {
                                                                            context.read<CollegeProvider>().changeCollegename =
                                                                                value;
                                                                            context.read<CourseProvider>().changeCollege =
                                                                                value;
                                                                          },
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'College'),
                                                                          validator:
                                                                              (value) {
                                                                            if (value == null ||
                                                                                value.isEmpty) {
                                                                              return 'Please enter college';
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
                                                              Expanded(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Form(
                                                                        key:
                                                                            _formKeyCourse,
                                                                        child:
                                                                            TextFormField(
                                                                          onChanged:
                                                                              (value) {
                                                                            context.read<CollegeProvider>().changeCourseName =
                                                                                value;
                                                                            context.read<CourseProvider>().changeCourseName =
                                                                                value;
                                                                          },
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'Course'),
                                                                          validator:
                                                                              (value) {
                                                                            if (value == null ||
                                                                                value.isEmpty) {
                                                                              return 'Please provide a course';
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Form(
                                                                        key:
                                                                            _formKeyYears,
                                                                        child:
                                                                            TextFormField(
                                                                          onChanged: (value) => context
                                                                              .read<CourseProvider>()
                                                                              .changeYears = int.parse(value),
                                                                          maxLength:
                                                                              1,
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'No. of Years'),
                                                                          validator:
                                                                              (value) {
                                                                            if (value == null ||
                                                                                value.isEmpty) {
                                                                              return 'Please provide completion year';
                                                                            }
                                                                            if (!numbers.contains(int.parse(value))) {
                                                                              return 'Not a valid year or years';
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Form(
                                                                        key:
                                                                            _formKeySections,
                                                                        child:
                                                                            TextFormField(
                                                                          onChanged: (value) => context
                                                                              .read<CourseProvider>()
                                                                              .changeSections = int.parse(value),
                                                                          maxLength:
                                                                              1,
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'No. of Sections'),
                                                                          validator:
                                                                              (value) {
                                                                            if (value == null ||
                                                                                value.isEmpty) {
                                                                              return 'Please provide number of sections';
                                                                            }
                                                                            if (!numbers.contains(int.parse(value))) {
                                                                              return 'Not a valid number of sections';
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
                                                                  if ((_formKeyCampus.currentState.validate() && _formKeyCollege.currentState.validate()) &&
                                                                      (_formKeyCourse
                                                                              .currentState
                                                                              .validate() &&
                                                                          _formKeyYears
                                                                              .currentState
                                                                              .validate()) &&
                                                                      _formKeySections
                                                                          .currentState
                                                                          .validate()) {
                                                                    await context
                                                                        .read<
                                                                            CollegeProvider>()
                                                                        .saveCollege();
                                                                    await context
                                                                        .read<
                                                                            CourseProvider>()
                                                                        .saveCourse();
                                                                    Future.delayed(
                                                                        const Duration(
                                                                            seconds:
                                                                                1),
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    });
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text('Successfully added.')),
                                                                    );
                                                                    //create activity
                                                                    String
                                                                        myName =
                                                                        await context
                                                                            .read<LocalDataProvider>()
                                                                            .getLocalAdminName();
                                                                    context
                                                                        .read<
                                                                            AdminActivityProvider>()
                                                                        .changeActivityTitle = 'Added a college';
                                                                    context
                                                                        .read<
                                                                            AdminActivityProvider>()
                                                                        .changeName = myName;
                                                                    context
                                                                            .read<
                                                                                AdminActivityProvider>()
                                                                            .changeDate =
                                                                        DateTime
                                                                            .now();
                                                                    await context
                                                                        .read<
                                                                            AdminActivityProvider>()
                                                                        .addActivity();
                                                                  }
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
                                  elevation: 9,
                                  child: Row(
                                    children: const [
                                      Icon(Icons.add),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text("Add College"),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            width: size.width * .03,
                          ),
                          context
                                  .watch<SelectionCollegeProvider>()
                                  .haveSelections
                              ? GFButton(
                                  onPressed: () {
                                    context
                                        .read<SelectionCollegeProvider>()
                                        .haveSelections = false;
                                    _dataGridController.selectedRows = [];
                                  },
                                  elevation: 9,
                                  color: Colors.blue,
                                  child: const Text("Cancel"),
                                )
                              : Container(),
                          context
                                  .watch<SelectionCollegeProvider>()
                                  .haveSelections
                              ? SizedBox(
                                  width: size.width * .03,
                                )
                              : Container(),
                          (context
                                      .watch<SelectionCollegeProvider>()
                                      .haveSelections &&
                                  context
                                      .watch<CollegeProvider>()
                                      .collegeNames
                                      .isNotEmpty)
                              ? context
                                          .watch<CollegeProvider>()
                                          .collegeNames
                                          .length >
                                      1
                                  ? Container()
                                  : GFButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Stack(
                                                children: [
                                                  SingleChildScrollView(
                                                    child: AlertDialog(
                                                      content: Container(
                                                        width: size.width / 3,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Form(
                                                                key:
                                                                    _formKeyNewCourse,
                                                                child:
                                                                    TextFormField(
                                                                  onChanged:
                                                                      (value) {
                                                                    context
                                                                        .read<
                                                                            CollegeProvider>()
                                                                        .changeNewCourse = value;
                                                                    context
                                                                        .read<
                                                                            CourseProvider>()
                                                                        .changeCourseName = value;
                                                                  },
                                                                  decoration: const InputDecoration(
                                                                      labelText:
                                                                          'New Course'),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Please enter a new course';
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
                                                                      .all(8.0),
                                                              child: Form(
                                                                key:
                                                                    _formKeyYears,
                                                                child:
                                                                    TextFormField(
                                                                  onChanged: (value) => context
                                                                          .read<
                                                                              CourseProvider>()
                                                                          .changeYears =
                                                                      int.parse(
                                                                          value),
                                                                  maxLength: 1,
                                                                  decoration: const InputDecoration(
                                                                      labelText:
                                                                          'No. of Years'),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Please provide completion year';
                                                                    }
                                                                    if (!numbers
                                                                        .contains(
                                                                            int.parse(value))) {
                                                                      return 'Not a valid year or years';
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
                                                                      .all(8.0),
                                                              child: Form(
                                                                key:
                                                                    _formKeySections,
                                                                child:
                                                                    TextFormField(
                                                                  onChanged: (value) => context
                                                                          .read<
                                                                              CourseProvider>()
                                                                          .changeSections =
                                                                      int.parse(
                                                                          value),
                                                                  maxLength: 1,
                                                                  decoration: const InputDecoration(
                                                                      labelText:
                                                                          'No. of Sections'),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Please provide number of sections';
                                                                    }
                                                                    if (!numbers
                                                                        .contains(
                                                                            int.parse(value))) {
                                                                      return 'Not a valid number of sections';
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
                                                                    if ((_formKeyNewCourse.currentState.validate() &&
                                                                            _formKeyYears.currentState
                                                                                .validate()) &&
                                                                        _formKeySections
                                                                            .currentState
                                                                            .validate()) {
                                                                      //update college value in course provider
                                                                      context
                                                                          .read<
                                                                              CourseProvider>()
                                                                          .changeCollege = context
                                                                              .read<
                                                                                  CollegeProvider>()
                                                                              .collegeNames[
                                                                          0];
                                                                      //add course to college collection
                                                                      context
                                                                          .read<
                                                                              CollegeProvider>()
                                                                          .addCourse();
                                                                      //add to course collection
                                                                      context
                                                                          .read<
                                                                              CourseProvider>()
                                                                          .saveCourse();
                                                                      //close dialog
                                                                      Future.delayed(
                                                                          const Duration(
                                                                              seconds: 1),
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      });
                                                                      //show snackbar
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        const SnackBar(
                                                                            content:
                                                                                Text('Successfully added.')),
                                                                      );
                                                                      //create activity
                                                                      String
                                                                          myName =
                                                                          await context
                                                                              .read<LocalDataProvider>()
                                                                              .getLocalAdminName();
                                                                      context
                                                                          .read<
                                                                              AdminActivityProvider>()
                                                                          .changeActivityTitle = 'Added a course';
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
                                                                    }
                                                                  },
                                                                  text: 'Add',
                                                                )
                                                              ],
                                                            )
                                                          ],
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
                                                        Navigator.of(context)
                                                            .pop();
                                                        context
                                                            .read<
                                                                SelectionCollegeProvider>()
                                                            .haveSelections = false;
                                                        context
                                                            .read<
                                                                CollegeProvider>()
                                                            .collegeNames = [];
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
                                      color: Colors.blue,
                                      child: const Text("Add Course"),
                                    )
                              : Container(),
                          context
                                  .watch<SelectionCollegeProvider>()
                                  .haveSelections
                              ? SizedBox(
                                  width: size.width * .03,
                                )
                              : Container(),
                          context
                                  .watch<SelectionCollegeProvider>()
                                  .haveSelections
                              ? GFButton(
                                  onPressed: () async {
                                    List deleteIDs = context
                                        .read<CollegeProvider>()
                                        .collegeNames;
                                    for (var i = 0; i < deleteIDs.length; i++) {
                                      await context
                                          .read<CollegeProvider>()
                                          .removeCollege(
                                              deleteIDs[i].toString());
                                    }
                                    context
                                        .read<SelectionCollegeProvider>()
                                        .haveSelections = false;
                                    context
                                        .read<CollegeProvider>()
                                        .collegeNames = [];
                                    //show snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Successfully deleted.')),
                                    );
                                    //create activity
                                    String myName = await context
                                        .read<LocalDataProvider>()
                                        .getLocalAdminName();
                                    context
                                            .read<AdminActivityProvider>()
                                            .changeActivityTitle =
                                        'Deleted a college';
                                    context
                                        .read<AdminActivityProvider>()
                                        .changeName = myName;
                                    context
                                        .read<AdminActivityProvider>()
                                        .changeDate = DateTime.now();
                                    context
                                        .read<AdminActivityProvider>()
                                        .addActivity();
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
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height:
                            (constraints.maxHeight / 1.1) - _dataPagerHeight,
                        width: constraints.maxWidth,
                        child: _buildDataGrid(constraints),
                      ),
                      // Container(
                      //   child: const Center(
                      //     child: Text(
                      //       'Working. Temporarily disabled\nto save data (data table)',
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No data'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDataGrid(BoxConstraints constraints) {
    List collegeNames = [];
    List<DataGridCell<dynamic>> selectedCells = [];
    return SfDataGrid(
      allowPullToRefresh: true,
      onSelectionChanged: (addedRows, removedRows) {
        addedRows = _dataGridController.selectedRows;
        addedRows.forEach((row) {
          selectedCells = row.getCells();
          selectedCells.forEach((cell) {
            if (cell.columnName == 'collegeName') {
              collegeNames.add(cell.value);
            }
          });
        });
        context.read<CollegeProvider>().collegeNames = collegeNames;
        print(context.read<CollegeProvider>().collegeNames);
      },
      onSelectionChanging: (addedRows, removedRows) {
        context.read<SelectionCollegeProvider>().haveSelections = true;
        return true;
      },
      controller: _dataGridController,
      showCheckboxColumn: true,
      selectionMode: SelectionMode.multiple,
      allowSorting: true,
      source: collegeDataSource2,
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'collegeName',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('College'),
          ),
        ),
        GridColumn(
          columnName: 'campus',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Campus'),
          ),
        ),
        GridColumn(
          columnName: 'courses',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Courses'),
          ),
        ),
      ],
    );
  }
}

class CollegeDataSource2 extends DataGridSource {
  /// Creates the employee data source class with required details.
  CollegeDataSource2({@required List<College> collegeData}) {
    _colleges = collegeData;
    _paginatedColleges =
        //studentData;
        _colleges.getRange(0, collegeData.length).toList(growable: false);
    buildPaginatedDataGridRows();
    notifyListeners();
  }

  List<College> _colleges = [];
  List<College> _paginatedColleges = [];
  List<DataGridRow> _collegeDataGridRows = [];

  @override
  List<DataGridRow> get rows => _collegeDataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      // if (dataGridCell.columnName == 'courses') {
      //   return
      // }
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }

  void buildPaginatedDataGridRows() {
    _collegeDataGridRows = _paginatedColleges.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'collegeName', value: e.collegeName),
        DataGridCell<String>(columnName: 'campus', value: e.campus),
        DataGridCell<List>(columnName: 'courses', value: e.courses),
      ]);
    }).toList(growable: false);
  }
}
