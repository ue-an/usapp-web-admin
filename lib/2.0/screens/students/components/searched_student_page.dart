// import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:provider/src/provider.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:web_tut/2.0/constants.dart';
// import 'package:web_tut/2.0/controllers/menu_controller.dart';
// import 'package:web_tut/2.0/responsive.dart';
// import 'package:web_tut/2.0/screens/students/components/sfdata_search.dart';
// import 'package:web_tut/2.0/screens/students/components/sfdata_search_provider.dart';
// import 'package:web_tut/models/student.dart';
// import 'package:web_tut/services/firestore_service.dart';

// double _dataPagerHeight = 60.0;
// final int _rowsPerPage = 15;
// List<Student> _paginatedStudents = [];
// List<Student> filteredSnaps = [];

// class SearchedStudentPage extends StatefulWidget {
//   String searchedRes;
//   SearchedStudentPage({Key key, this.searchedRes}) : super(key: key);
//   @override
//   State<SearchedStudentPage> createState() => _SearchedStudentPageState();
// }

// class _SearchedStudentPageState extends State<SearchedStudentPage>
//     with AutomaticKeepAliveClientMixin<SearchedStudentPage> {
//   @override
//   bool get wantKeepAlive => true;
//   FirestoreService firestoreService = FirestoreService();
//   Stream<List<Student>> _streamSearchedStudents;
//   StudentDataSource2 studentDataSource2;
//   @override
//   void initState() {
//     _streamSearchedStudents =
//         firestoreService.searchStudents(widget.searchedRes);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Container(
//         padding: const EdgeInsets.all(defaultPadding),
//         child: StreamBuilder<List<Student>>(
//           stream: _streamSearchedStudents,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(
//                 child: Text('No data'),
//               );
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (snapshot.hasData) {
//               snapshot.data.forEach((snap) {
//                 if (snap.lastName == widget.searchedRes) {
//                   filteredSnaps.add(snap);
//                 }
//               });
//               studentDataSource2 = StudentDataSource2(
//                 studentData: filteredSnaps,
//               );
//               // return LayoutBuilder(
//               //   builder: (context, constraint) {
//               //     return Column(
//               //       children: [
//               //         Row(
//               //           children: [
//               //             if (!Responsive.isDesktop(context))
//               //               IconButton(
//               //                 icon: const Icon(Icons.menu),
//               //                 onPressed:
//               //                     context.read<MenuController>().controlMenu,
//               //               ),
//               //             if (!Responsive.isMobile(context))
//               //               Text(
//               //                 "Students",
//               //                 style: Theme.of(context).textTheme.headline6,
//               //               ),
//               //             if (!Responsive.isMobile(context))
//               //               Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
//               //             const Expanded(child: SFDataSearchField()),
//               //             SizedBox(
//               //               width: size.width * .03,
//               //             ),
//               //             GFButton(
//               //               onPressed: () {},
//               //               elevation: 9,
//               //               child: Row(
//               //                 children: const [
//               //                   Icon(Icons.add),
//               //                   SizedBox(
//               //                     width: 12,
//               //                   ),
//               //                   Text("Add Student"),
//               //                 ],
//               //               ),
//               //             ),
//               //             SizedBox(
//               //               width: size.width * .03,
//               //             ),
//               //             GFButton(
//               //               onPressed: () {},
//               //               elevation: 9,
//               //               color: Colors.green,
//               //               child: Row(
//               //                 children: [
//               //                   Image.asset(
//               //                     'assets/images/ic_import-csv-24.png',
//               //                   ),
//               //                   const SizedBox(
//               //                     width: 12,
//               //                   ),
//               //                   const Text("CSV File"),
//               //                 ],
//               //               ),
//               //             ),
//               //           ],
//               //         ),
//               //         SizedBox(
//               //           height: (constraint.maxHeight / 1.1) - _dataPagerHeight,
//               //           width: constraint.maxWidth,
//               //           child: _buildDataGrid(constraint),
//               //         ),
//               //         Container(
//               //           child: SfDataPager(
//               //             delegate: studentDataSource2,
//               //             pageCount:
                              // context.read<SFDataSearchProvider>().searchText ==
                              //         ''
                              //     ? 1
                              //     : filteredSnaps.length /
                              //         studentDataSource2.rowsPerPage,
//               //             direction: Axis.horizontal,
//               //           ),
//               //         )
//               //       ],
//               //     );
//               //   },
//               // );
//               return Container(
//                 color: Colors.red,
//               );
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDataGrid(BoxConstraints constraint) {
//     return SfDataGrid(
//       showCheckboxColumn: true,
//       selectionMode: SelectionMode.multiple,
//       allowSorting: true,
//       source: studentDataSource2,
//       columnWidthMode: ColumnWidthMode.fill,
//       columns: <GridColumn>[
//         GridColumn(
//           columnName: 'id',
//           label: Container(
//             padding: const EdgeInsets.all(8.0),
//             alignment: Alignment.center,
//             child: const Text('ID'),
//           ),
//         ),
//         // GridColumn(
//         //   columnName: 'photo',
//         //   label: Container(
//         //     padding: const EdgeInsets.all(8.0),
//         //     alignment: Alignment.center,
//         //     child: const Text('Photo'),
//         //   ),
//         // ),
//         GridColumn(
//           columnName: 'firstName',
//           label: Container(
//             padding: const EdgeInsets.all(8.0),
//             alignment: Alignment.center,
//             child: const Text('First Name'),
//           ),
//         ),
//         GridColumn(
//           columnName: 'middleInitial',
//           label: Container(
//             padding: const EdgeInsets.all(8.0),
//             alignment: Alignment.center,
//             child: const Text('Middle Initial'),
//           ),
//         ),
//         GridColumn(
//           columnName: 'lastName',
//           label: Container(
//             padding: const EdgeInsets.all(8.0),
//             alignment: Alignment.center,
//             child: const Text('Last Name'),
//           ),
//         ),
//         GridColumn(
//           columnName: 'course',
//           label: Container(
//             padding: const EdgeInsets.all(8.0),
//             alignment: Alignment.center,
//             child: const Text('Course'),
//           ),
//         ),
//         GridColumn(
//           columnName: 'yearLevel',
//           label: Container(
//             padding: const EdgeInsets.all(8.0),
//             alignment: Alignment.center,
//             child: const Text('Year Level'),
//           ),
//         ),
//         GridColumn(
//           columnName: 'section',
//           label: Container(
//             padding: const EdgeInsets.all(8.0),
//             alignment: Alignment.center,
//             child: const Text('Section'),
//           ),
//         ),
//         GridColumn(
//           columnName: 'college',
//           label: Container(
//             padding: const EdgeInsets.all(8.0),
//             alignment: Alignment.center,
//             child: const Text('College'),
//           ),
//         ),
//         GridColumn(
//           columnName: 'email',
//           label: Container(
//             padding: const EdgeInsets.all(8.0),
//             alignment: Alignment.center,
//             child: const Text('Email'),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class StudentDataSource2 extends DataGridSource {
//   List<DataGridRow> dataGridRows = [];
//   int get rowsPerPage => _rowsPerPage;

//   /// Creates the employee data source class with required details.
//   StudentDataSource2({List<Student> studentData}) {
//     _studentData = studentData
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<int>(
//                   columnName: 'id', value: int.parse(e.studentNumber)),
//               // DataGridCell<String>(columnName: 'photo', value: e.photo),
//               DataGridCell<String>(columnName: 'firstName', value: e.firstName),
//               DataGridCell<String>(
//                   columnName: 'middleInitial', value: e.mInitial),
//               DataGridCell<String>(columnName: 'lastName', value: e.lastName),
//               DataGridCell<String>(columnName: 'course', value: e.course),
//               DataGridCell<int>(columnName: 'yearLevel', value: e.yearLvl),
//               DataGridCell<int>(columnName: 'section', value: e.section),
//               DataGridCell<String>(columnName: 'college', value: e.college),
//               DataGridCell<String>(columnName: 'email', value: e.email),
//             ]))
//         .toList();
//   }

//   List<DataGridRow> _studentData = [];

//   @override
//   List<DataGridRow> get rows => _studentData;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((e) {
//       // if (e.columnName == 'photo') {
//       //   return Container(
//       //     padding: EdgeInsets.symmetric(horizontal: 16.0),
//       //     alignment: Alignment.centerRight,
//       //     // child: ClipRRect(
//       //     //   child: Image.network(e.value),
//       //     // )
//       //     child: Image.network(
//       //       e.value,
//       //       height: 20,
//       //       width: 20,
//       //     ),
//       //   );
//       // }
//       return Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(8.0),
//         child: Text(e.value.toString()),
//       );
//     }).toList());
//   }

//   @override
//   Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
//     int startIndex = newPageIndex * _rowsPerPage;
//     int endIndex = startIndex + _rowsPerPage;
//     if (startIndex < filteredSnaps.length && endIndex <= filteredSnaps.length) {
//       _paginatedStudents =
//           filteredSnaps.getRange(startIndex, endIndex).toList(growable: false);
//       buildPaginatedDataGridRows();
//       notifyListeners();
//     } else {
//       _paginatedStudents = [];
//     }

//     return true;
//   }

//   void buildPaginatedDataGridRows() {
//     dataGridRows = _paginatedStudents.map<DataGridRow>((e) {
//       return DataGridRow(cells: [
//         DataGridCell<int>(columnName: 'id', value: int.parse(e.studentNumber)),
//         DataGridCell<String>(columnName: 'firstName', value: e.firstName),
//         DataGridCell<String>(columnName: 'middleInitial', value: e.mInitial),
//         DataGridCell<String>(columnName: 'lastName', value: e.lastName),
//         DataGridCell<String>(columnName: 'course', value: e.course),
//         DataGridCell<int>(columnName: 'yearLevel', value: e.yearLvl),
//         DataGridCell<int>(columnName: 'section', value: e.section),
//         DataGridCell<String>(columnName: 'college', value: e.college),
//         DataGridCell<String>(columnName: 'email', value: e.email),
//       ]);
//     }).toList(growable: false);
//   }
// }
