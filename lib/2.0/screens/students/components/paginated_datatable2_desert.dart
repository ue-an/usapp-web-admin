// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:data_table_2/data_table_2.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:web_tut/2.0/constants.dart';
// import 'package:web_tut/2.0/responsive.dart';
// import 'package:web_tut/2.0/screens/dashboard/components/students_datatable_source.dart';
// import 'package:web_tut/2.0/screens/students/components/custom_pager.dart';
// import 'package:web_tut/2.0/screens/students/components/nav_helper.dart';
// import 'package:web_tut/models/student.dart';

// // Copyright 2019 The Flutter team. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // The file was extracted from GitHub: https://github.com/flutter/gallery
// // Changes and modifications by Maxim Saplin, 2021

// class PaginatedDataTable2Desert extends StatefulWidget {
//   Stream<List<Student>> streamStudents;
//   PaginatedDataTable2Desert({Key key, @required this.streamStudents})
//       : super(key: key);

//   @override
//   _PaginatedDataTable2DesertState createState() =>
//       _PaginatedDataTable2DesertState();
// }

// class _PaginatedDataTable2DesertState extends State<PaginatedDataTable2Desert> {
//   int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
//   bool _sortAscending = true;
//   int _sortColumnIndex;
//   DessertDataSource _dessertsDataSource;
//   bool _initialized = false;
//   PaginatorController _controller;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_initialized) {
//       _dessertsDataSource = DessertDataSource(
//           context, getCurrentRouteOption(context) == defaultSorting);

//       _controller = PaginatorController();

//       if (getCurrentRouteOption(context) == defaultSorting) {
//         _sortColumnIndex = 1;
//       }
//       _initialized = true;
//     }
//   }

//   void sort<T>(
//     Comparable<T> Function(Dessert d) getField,
//     int columnIndex,
//     bool ascending,
//   ) {
//     _dessertsDataSource.sort<T>(getField, ascending);
//     setState(() {
//       _sortColumnIndex = columnIndex;
//       _sortAscending = ascending;
//     });
//   }

//   @override
//   void dispose() {
//     _dessertsDataSource.dispose();
//     super.dispose();
//   }

//   List<DataColumn> get _columns {
//     return [
//       DataColumn(
//         label: Text('Desert'),
//         onSort: (columnIndex, ascending) =>
//             sort<String>((d) => d.name, columnIndex, ascending),
//       ),
//       DataColumn(
//         label: Text('Calories'),
//         numeric: true,
//         onSort: (columnIndex, ascending) =>
//             sort<num>((d) => d.calories, columnIndex, ascending),
//       ),
//       DataColumn(
//         label: Text('Fat (gm)'),
//         numeric: true,
//         onSort: (columnIndex, ascending) =>
//             sort<num>((d) => d.fat, columnIndex, ascending),
//       ),
//       DataColumn(
//         label: Text('Carbs (gm)'),
//         numeric: true,
//         onSort: (columnIndex, ascending) =>
//             sort<num>((d) => d.carbs, columnIndex, ascending),
//       ),
//       DataColumn(
//         label: Text('Protein (gm)'),
//         numeric: true,
//         onSort: (columnIndex, ascending) =>
//             sort<num>((d) => d.protein, columnIndex, ascending),
//       ),
//       DataColumn(
//         label: Text('Sodium (mg)'),
//         numeric: true,
//         onSort: (columnIndex, ascending) =>
//             sort<num>((d) => d.sodium, columnIndex, ascending),
//       ),
//       DataColumn(
//         label: Text('Calcium (%)'),
//         numeric: true,
//         onSort: (columnIndex, ascending) =>
//             sort<num>((d) => d.calcium, columnIndex, ascending),
//       ),
//       DataColumn(
//         label: Text('Iron (%)'),
//         numeric: true,
//         onSort: (columnIndex, ascending) =>
//             sort<num>((d) => d.iron, columnIndex, ascending),
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         PaginatedDataTable2(
//           actions: [
//             ElevatedButton.icon(
//               style: TextButton.styleFrom(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: defaultPadding * 1.5,
//                   vertical:
//                       defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
//                 ),
//               ),
//               onPressed: () {},
//               icon: const Icon(Icons.add),
//               label: const Text("Add New Student"),
//             ),
//             const SizedBox(
//               width: 12,
//             ),
//             GFButton(
//               color: Colors.green,
//               onPressed: () {},
//               padding: EdgeInsets.symmetric(
//                   horizontal: _size.width * .02, vertical: _size.height * .01),
//               size: GFSize.LARGE,
//               child: Row(
//                 children: [
//                   Image.asset('assets/images/ic_import-csv-24.png'),
//                   SizedBox(
//                     width: _size.width * .01,
//                   ),
//                   const Text("Import CSV File"),
//                 ],
//               ),
//             ),
//           ],
//           showFirstLastButtons: true,
//           horizontalMargin: 20,
//           checkboxHorizontalMargin: 12,
//           columnSpacing: 0,
//           wrapInCard: false,
//           header: Text('Students'),
//           rowsPerPage: _rowsPerPage,
//           autoRowsToHeight: getCurrentRouteOption(context) == autoRows,
//           minWidth: 800,
//           fit: FlexFit.tight,
//           border: TableBorder(
//               top: BorderSide(color: Colors.black),
//               bottom: BorderSide(color: Colors.grey[300]),
//               left: BorderSide(color: Colors.grey[300]),
//               right: BorderSide(color: Colors.grey[300]),
//               verticalInside: BorderSide(color: Colors.grey[300]),
//               horizontalInside: BorderSide(color: Colors.grey, width: 1)),
//           // onRowsPerPageChanged: (value) {
//           // No need to wrap into setState, it will be called inside the widget
//           // and trigger rebuild
//           //setState(() {
//           // _rowsPerPage = value;
//           // print(_rowsPerPage);
//           //});
//           // },
//           initialFirstRowIndex: 0,
//           onPageChanged: (rowIndex) {
//             print(rowIndex / _rowsPerPage);
//           },
//           sortColumnIndex: _sortColumnIndex,
//           sortAscending: _sortAscending,
//           onSelectAll: _dessertsDataSource.selectAll,
//           controller:
//               getCurrentRouteOption(context) == custPager ? _controller : null,
//           hidePaginator: getCurrentRouteOption(context) == custPager,
//           columns: _columns,
//           empty: Center(
//               child: Container(
//                   padding: EdgeInsets.all(20),
//                   color: Colors.grey[200],
//                   child: Text('No data'))),
//           source: getCurrentRouteOption(context) == noData
//               ? DessertDataSource.empty(context)
//               : _dessertsDataSource,
//         ),
//         if (getCurrentRouteOption(context) == custPager)
//           Positioned(bottom: 16, child: CustomPager(_controller))
//       ],
//     );
//   }
// }
