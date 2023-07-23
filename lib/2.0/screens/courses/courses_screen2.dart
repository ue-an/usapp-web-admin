import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/courses/components/college_dropdown.dart';
import 'package:web_tut/2.0/screens/courses/components/selection_course_provider.dart';
import 'package:web_tut/2.0/screens/students/components/selection_provider.dart';
import 'package:web_tut/models/course.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/college_provider.dart';
import 'package:web_tut/providers/course_provider.dart';
import 'package:web_tut/services/firestore_service.dart';

double _dataPagerHeight = 60.0;
final DataGridController _dataGridController = DataGridController();

class CoursesScreen2 extends StatefulWidget {
  const CoursesScreen2({Key key}) : super(key: key);

  @override
  State<CoursesScreen2> createState() => _CoursesScreen2State();
}

class _CoursesScreen2State extends State<CoursesScreen2>
    with AutomaticKeepAliveClientMixin<CoursesScreen2> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<Course>> _streamCourse;
  CourseDataSource2 courseDataSource2;
  final _formKeyCourse = GlobalKey<FormState>();
  final _formKeyYears = GlobalKey<FormState>();
  final _formKeySections = GlobalKey<FormState>();
  final _formKeyEditYears = GlobalKey<FormState>();
  final _formKeyEditSections = GlobalKey<FormState>();
  List<int> numbers = [2, 3, 4, 5, 6, 7, 8, 9];
  @override
  void initState() {
    _streamCourse = firestoreService.getCourses();

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
        child: StreamBuilder(
          stream: _streamCourse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              courseDataSource2 = CourseDataSource2(courseData: snapshot.data);
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
                              "List of Courses",
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
                                  .watch<SelectionCourseProvider>()
                                  .haveSelections
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
                                                      CollegeDropdown(),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Form(
                                                          key: _formKeyCourse,
                                                          child: TextFormField(
                                                            onChanged: (value) {
                                                              context
                                                                  .read<
                                                                      CollegeProvider>()
                                                                  .changeNewCourse = value;
                                                              context
                                                                  .read<
                                                                      CourseProvider>()
                                                                  .changeCourseName = value;
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        'New Course'),
                                                            validator: (value) {
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
                                                          key: _formKeyYears,
                                                          child: TextFormField(
                                                            onChanged: (value) => context
                                                                    .read<
                                                                        CourseProvider>()
                                                                    .changeYears =
                                                                int.parse(
                                                                    value),
                                                            maxLength: 1,
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        'No. of Years'),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Please provide completion year';
                                                              }
                                                              if (!numbers.contains(
                                                                  int.parse(
                                                                      value))) {
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
                                                          key: _formKeySections,
                                                          child: TextFormField(
                                                            onChanged: (value) => context
                                                                    .read<
                                                                        CourseProvider>()
                                                                    .changeSections =
                                                                int.parse(
                                                                    value),
                                                            maxLength: 1,
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        'No. of Sections'),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Please provide number of sections';
                                                              }
                                                              if (!numbers.contains(
                                                                  int.parse(
                                                                      value))) {
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
                                                              if ((_formKeyCourse
                                                                          .currentState
                                                                          .validate() &&
                                                                      _formKeyYears
                                                                          .currentState
                                                                          .validate()) &&
                                                                  _formKeySections
                                                                      .currentState
                                                                      .validate()) {
                                                                //add course to college collection
                                                                await context
                                                                    .read<
                                                                        CollegeProvider>()
                                                                    .addCourseFromCourse();
                                                                //add to course collection
                                                                await context
                                                                    .read<
                                                                        CourseProvider>()
                                                                    .saveCourse();
                                                                //close dialog
                                                                Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                    () {
                                                                  context
                                                                      .read<
                                                                          CollegeProvider>()
                                                                      .collegeNames = [];
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                });
                                                                //show snackbar
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Successfully added.')),
                                                                );
                                                                //create activity
                                                                String myName =
                                                                    await context
                                                                        .read<
                                                                            LocalDataProvider>()
                                                                        .getLocalAdminName();
                                                                context
                                                                        .read<
                                                                            AdminActivityProvider>()
                                                                        .changeActivityTitle =
                                                                    'Added a course';
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
                                                  Navigator.of(context).pop();
                                                  context
                                                      .read<
                                                          SelectionCourseProvider>()
                                                      .haveSelections = false;
                                                  context
                                                      .read<CourseProvider>()
                                                      .changeCourseNames = [];
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
                                  elevation: 9,
                                  child: Row(
                                    children: const [
                                      Icon(Icons.add),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text("Add Course"),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            width: size.width * .03,
                          ),
                          context
                                  .watch<SelectionCourseProvider>()
                                  .haveSelections
                              ? GFButton(
                                  onPressed: () {
                                    context
                                        .read<SelectionCourseProvider>()
                                        .haveSelections = false;
                                    _dataGridController.selectedRows = [];
                                  },
                                  elevation: 9,
                                  color: Colors.blue,
                                  child: const Text("Cancel"),
                                )
                              : Container(),
                          context
                                  .watch<SelectionCourseProvider>()
                                  .haveSelections
                              ? SizedBox(
                                  width: size.width * .03,
                                )
                              : Container(),
                          (context
                                      .watch<SelectionCourseProvider>()
                                      .haveSelections &&
                                  context
                                      .watch<CourseProvider>()
                                      .courseNames
                                      .isNotEmpty)
                              ? context
                                          .watch<CourseProvider>()
                                          .courseNames
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
                                                              child:
                                                                  TextFormField(
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white54,
                                                                ),
                                                                initialValue: context
                                                                    .read<
                                                                        CollegeProvider>()
                                                                    .collegeNames[0],
                                                                decoration: const InputDecoration(
                                                                    enabled:
                                                                        false,
                                                                    labelText:
                                                                        'College'),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Form(
                                                              child:
                                                                  TextFormField(
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white54,
                                                                ),
                                                                initialValue: context
                                                                    .read<
                                                                        CourseProvider>()
                                                                    .courseNames[0],
                                                                decoration: const InputDecoration(
                                                                    enabled:
                                                                        false,
                                                                    labelText:
                                                                        'Course'),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Form(
                                                              key:
                                                                  _formKeyEditYears,
                                                              child:
                                                                  TextFormField(
                                                                initialValue: context
                                                                    .read<
                                                                        CourseProvider>()
                                                                    .editYears
                                                                    .toString(),
                                                                onChanged: (value) => context
                                                                        .read<
                                                                            CourseProvider>()
                                                                        .editYears =
                                                                    int.parse(
                                                                        value),
                                                                maxLength: 1,
                                                                decoration:
                                                                    const InputDecoration(
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
                                                                  if (!numbers.contains(
                                                                      int.parse(
                                                                          value))) {
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
                                                                  _formKeyEditSections,
                                                              child:
                                                                  TextFormField(
                                                                initialValue: context
                                                                    .read<
                                                                        CourseProvider>()
                                                                    .editSections
                                                                    .toString(),
                                                                onChanged: (value) => context
                                                                        .read<
                                                                            CourseProvider>()
                                                                        .editSections =
                                                                    int.parse(
                                                                        value),
                                                                maxLength: 1,
                                                                decoration:
                                                                    const InputDecoration(
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
                                                                  if (!numbers.contains(
                                                                      int.parse(
                                                                          value))) {
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
                                                                  if ((_formKeyEditYears
                                                                          .currentState
                                                                          .validate()) &&
                                                                      _formKeyEditSections
                                                                          .currentState
                                                                          .validate()) {
                                                                    //add course to college collection
                                                                    // await context
                                                                    //     .read<
                                                                    //         CollegeProvider>()
                                                                    //     .addCourseFromCourse();
                                                                    //add to course collection
                                                                    await context
                                                                        .read<
                                                                            CourseProvider>()
                                                                        .updateCourse();
                                                                    //close dialog
                                                                    Future.delayed(
                                                                        const Duration(
                                                                            seconds:
                                                                                1),
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              CollegeProvider>()
                                                                          .collegeNames = [];
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    });
                                                                    //show snackbar
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text('Changes saved.')),
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
                                                                        .changeActivityTitle = 'Updated course details';
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
                                                                text:
                                                                    'Save changes',
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
                                                              SelectionCourseProvider>()
                                                          .haveSelections = false;
                                                      context
                                                          .read<
                                                              CourseProvider>()
                                                          .changeCourseNames = [];
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
                                          },
                                        );
                                      },
                                      elevation: 9,
                                      color: Colors.blue,
                                      child: const Text("Edit"),
                                    )
                              : Container(),
                          context
                                  .watch<SelectionCourseProvider>()
                                  .haveSelections
                              ? SizedBox(
                                  width: size.width * .03,
                                )
                              : Container(),
                          context
                                  .watch<SelectionCourseProvider>()
                                  .haveSelections
                              ? GFButton(
                                  onPressed: () async {
                                    List deleteIDs = context
                                        .read<CourseProvider>()
                                        .courseNames;
                                    for (var i = 0; i < deleteIDs.length; i++) {
                                      await context
                                          .read<CourseProvider>()
                                          .removeCourse(
                                              deleteIDs[i].toString());
                                      await context
                                          .read<CollegeProvider>()
                                          .removeCourseFromCourse(
                                              context
                                                  .read<CollegeProvider>()
                                                  .collegeNames[i],
                                              context
                                                  .read<CourseProvider>()
                                                  .courseNames[i]);
                                      //create activity
                                      String myName = await context
                                          .read<LocalDataProvider>()
                                          .getLocalAdminName();
                                      context
                                              .read<AdminActivityProvider>()
                                              .changeActivityTitle =
                                          'Deleted a course';
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
                                    context
                                        .read<SelectionCourseProvider>()
                                        .haveSelections = false;
                                    context
                                        .read<CourseProvider>()
                                        .changeCourseNames = [];
                                    //show snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Successfully deleted.')),
                                    );
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
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildDataGrid(BoxConstraints constraints) {
    List courseNames = [];
    List collegeNames = [];
    List<DataGridCell<dynamic>> selectedCells = [];
    return SfDataGrid(
      allowPullToRefresh: true,
      onSelectionChanged: (addedRows, removedRows) {
        addedRows = _dataGridController.selectedRows;
        addedRows.forEach((row) {
          selectedCells = row.getCells();
          selectedCells.forEach((cell) {
            if (cell.columnName == 'courseName') {
              courseNames.add(cell.value);
              context.read<CourseProvider>().editCourseID = cell.value;
            }
            if (cell.columnName == 'college') {
              collegeNames.add(cell.value);
            }
            if (cell.columnName == 'years') {
              context.read<CourseProvider>().editYears = cell.value;
            }
            if (cell.columnName == 'sections') {
              context.read<CourseProvider>().editSections = cell.value;
            }
          });
        });
        context.read<CourseProvider>().changeCourseNames = courseNames;
        context.read<CollegeProvider>().collegeNames = collegeNames;
        print(context.read<CourseProvider>().courseNames);
        print(context.read<CollegeProvider>().collegeNames);
        print('================');
        print(context.read<CourseProvider>().editCourseID);
        print(context.read<CourseProvider>().editSections);
        print(context.read<CourseProvider>().editYears);
      },
      onSelectionChanging: (addedRows, removedRows) {
        context.read<SelectionCourseProvider>().haveSelections = true;
        return true;
      },
      controller: _dataGridController,
      showCheckboxColumn: true,
      selectionMode: SelectionMode.multiple,
      allowSorting: true,
      source: courseDataSource2,
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'courseName',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Course'),
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
          columnName: 'years',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('No. of Years'),
          ),
        ),
        GridColumn(
          columnName: 'sections',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('No. of Sections'),
          ),
        ),
      ],
    );
  }
}

class CourseDataSource2 extends DataGridSource {
  /// Creates the employee data source class with required details.
  CourseDataSource2({@required List<Course> courseData}) {
    _courses = courseData;
    _paginatedCourses =
        //studentData;
        _courses.getRange(0, courseData.length).toList(growable: false);
    buildPaginatedDataGridRows();
    notifyListeners();
  }

  List<Course> _courses = [];
  List<Course> _paginatedCourses = [];
  List<DataGridRow> _courseDataGridRows = [];

  @override
  List<DataGridRow> get rows => _courseDataGridRows;

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
    _courseDataGridRows = _paginatedCourses.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'courseName', value: e.courseName),
        DataGridCell<String>(columnName: 'college', value: e.college),
        DataGridCell<int>(columnName: 'years', value: e.years),
        DataGridCell<int>(columnName: 'sections', value: e.sections),
      ]);
    }).toList(growable: false);
  }
}
