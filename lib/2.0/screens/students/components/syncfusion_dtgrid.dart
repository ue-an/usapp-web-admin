// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:web_tut/2.0/screens/students/components/sfdata_provider.dart';
// import 'package:web_tut/models/student.dart';

// class StudentDataSource2 extends DataGridSource {
//   final int _rowsPerPage = 15;
//   final List<Student> _students = [];
//   List<Student> _paginatedStudents = [];
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
//     if (startIndex < _students.length && endIndex <= _students.length) {
//       _paginatedStudents =
//           _students.getRange(startIndex, endIndex).toList(growable: false);
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
