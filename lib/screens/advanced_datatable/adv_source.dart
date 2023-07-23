// import 'package:advanced_datatable/advanced_datatable.dart';
// import 'package:advanced_datatable/advanced_datatable_source.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:web_tut/models/student.dart';
// import 'package:flutter/material.dart';

// class AdvancedSource extends AdvancedDataTableSource {
//   final List<Student> students;

//   AdvancedSource(this.students);

//   @override
//   DataRow getRow(int index) {
//     assert(index >= 0);

//     if (index >= students.length) {
//       return null;
//     }
//     // List<Student> students;
//     // StreamBuilder(
//     //     stream: FirebaseFirestore.instance.collection('students').snapshots(),
//     //     builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
//     //       students =
//     //           snap.data.docs.map((e) => Student.fromJson(e.data())).toList();

//     //       DataTableSource _allUsers = StudData(students);
//     //       if (snap.connectionState == ConnectionState.waiting) {
//     //         return Center(child: CircularProgressIndicator());
//     //       }
//     //       if (snap.hasData) {
//     //         return SingleChildScrollView(
//     //           child: PaginatedDataTable(
//     //             sortAscending: _isAscending,
//     //             header: const Text("Students"),
//     //             rowsPerPage: userdataNotifier.rowsPerPage,
//     //             columns: _colGen(_allUsers, userdataNotifier),
//     //             source: _allUsers,
//     //           ),
//     //         );
//     //       }
//     //       return Center(child: CircularProgressIndicator());
//     //     });

//     return DataRow.byIndex(cells: [
//       DataCell(Text(students[index].studentNumber)),
//       DataCell(Text(students[index].firstName)),
//       DataCell(Text(students[index].mInitial)),
//       DataCell(Text(students[index].lastName)),
//       DataCell(Text(students[index].course)),
//       DataCell(Text(students[index].yearSec)),
//       DataCell(Text(students[index].email)),
//       DataCell(Text(students[index].college)),
//     ], index: index);
//   }

//   // @override
//   // bool get isRowCountApproximate => false;

//   // @override
//   // int get rowCount => students.length;

//   // @override
//   // int get selectedRowCount => 0;

//     @override
//   DataRow getRow(int index) =>
//       lastDetails.rows[index].getRow(selectedRow, selectedIds);

//   @override
//   int get selectedRowCount => selectedIds.length;

//   void selectedRow(String id, bool newSelectState) {
//     if (selectedIds.contains(id)) {
//       selectedIds.remove(id);
//     } else {
//       selectedIds.add(id);
//     }
//     notifyListeners();
//   }

//   void filterServerSide(String filterQuery) {
//     lastSearchTerm = filterQuery.toLowerCase().trim();
//     setNextView();
//   }

//   @override
//   Future<RemoteDataSourceDetails> getNextPage(
//       NextPageRequest pageRequest) async {
//     return RemoteDataSourceDetails(
//       students.length,
//       students.skip(pageRequest.offset).take(pageRequest.pageSize).toList(),
//       filteredRows:
//           students.length, //the total amount of filtered rows, null by default
//     );
//   }

//   sort<T>(Comparable<T> Function(Student s) getField, bool ascending) {
//     students.sort((a, b) {
//       final aValue = getField(a);
//       final bValue = getField(b);
//       return ascending
//           ? Comparable.compare(aValue, bValue)
//           : Comparable.compare(bValue, aValue);
//     });
//     notifyListeners();
//   }
// }
