// import 'package:data_table_2/data_table_2.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:web_tut/models/student.dart';
// import 'package:web_tut/utils/constants.dart';

// class RestorableStudentsSelections extends RestorableProperty<Set<int>> {
//   Set<int> _studentSelections = {};

//   bool isSelected(int index) => _studentSelections.contains(index);
//   void setStudentSelections(List<Student> students) {
//     final updatedSet = <int>{};
//     for (var i = 0; i < students.length; i += 1) {
//       var student = students[i];
//       if (student.selected) {
//         updatedSet.add(i);
//       }
//     }
//     _studentSelections = updatedSet;
//     notifyListeners();
//   }

//   @override
//   Set<int> createDefaultValue() => _studentSelections;
//   @override
//   Set<int> fromPrimitives(Object data) {
//     final selectedItemIndices = data as List<dynamic>;
//     _studentSelections = {
//       ...selectedItemIndices.map<int>((dynamic id) => id as int),
//     };
//     return _studentSelections;
//   }

//   @override
//   void initWithValue(Set<int> value) {
//     _studentSelections = value;
//   }

//   @override
//   Object toPrimitives() => _studentSelections.toList();
// }

// class StudentDataSource extends DataTableSource {
//   StudentDataSource.empty(this.context) {
//     students = [];
//   }

//   StudentDataSource(this.context,
//       [sortedByLastName = false,
//       this.hasRowTaps = false,
//       this.hasRowHeightOverrides = false]) {
//     students = _students;
//     if (sortedByLastName) {
//       sort((s) => s.lastName, true);
//     }
//   }

//   final BuildContext context;
//   List<Student> students;
//   bool hasRowTaps;
//   bool hasRowHeightOverrides;

//   void sort<T>(Comparable<T> Function(Student s) getField, bool ascending) {
//     students.sort((a, b) {
//       final aValue = getField(a);
//       final bValue = getField(b);
//       return ascending
//           ? Comparable.compare(aValue, bValue)
//           : Comparable.compare(aValue, bValue);
//     });
//     notifyListeners();
//   }

//   int _selectedCount = 0;
//   void updateSelectedStudents(RestorableStudentsSelections selectedRows) {
//     _selectedCount = 0;
//     for (var i = 0; i < students.length; i += 1) {
//       var student = students[i];
//       if (selectedRows.isSelected(i)) {
//         student.selected = true;
//         _selectedCount += 1;
//       } else {
//         student.selected = false;
//       }
//     }
//     notifyListeners();
//   }

//   @override
//   DataRow getRow(int index) {
//     final format = NumberFormat.decimalPercentPattern(
//       locale: 'en',
//       decimalDigits: 0,
//     );
//     assert(index >= 0);
//     if (index >= students.length) throw 'index > _students.length';
//     final student = students[index];
//     return DataRow2.byIndex(
//       index: index,
//       selected: student.selected,
//       onSelectChanged: hasRowTaps
//           ? null
//           : (value) {
//               if (student.selected != value) {
//                 _selectedCount += value ? 1 : -1;
//                 assert(_selectedCount >= 0);
//                 student.selected = value;
//                 notifyListeners();
//               }
//             },
//       onTap: hasRowTaps
//           ? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('Tapped on${student.lastName}'),
//                 duration: Duration(seconds: 1),
//               ))
//           : null,
//       onDoubleTap: hasRowTaps
//           ? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 duration: Duration(seconds: 1),
//                 backgroundColor: Theme.of(context).focusColor,
//                 content: Text('Double Tapped on ${student.lastName}'),
//               ))
//           : null,
//       onSecondaryTap: hasRowTaps
//           ? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 duration: Duration(seconds: 1),
//                 backgroundColor: Theme.of(context).errorColor,
//                 content: Text('Right clicked on ${student.lastName}'),
//               ))
//           : null,
//       specificRowHeight:
//           this.hasRowHeightOverrides && student.lastName.length >= 6
//               ? 100
//               : null,
//       cells: [
//         DataCell(Text(student.studentNumber)),
//         DataCell(Text(student.firstName)),
//         DataCell(Text(student.mInitial)),
//         DataCell(Text(student.lastName)),
//         DataCell(Text(student.course)),
//         DataCell(Text(student.yearLvl.toString())),
//         DataCell(Text(student.section.toString())),
//         DataCell(Text(student.college.toString())),
//         DataCell(Text(student.email)),
//         DataCell(Row(
//           children: [
//             IconButton(
//               hoverColor: kMiddleColor.withOpacity(.3),
//               splashColor: Colors.transparent,
//               icon: Icon(
//                 Icons.edit,
//                 color: kPrimaryColor,
//               ),
//               // onPressed: () => onRowSelect(index),
//               onPressed: () {},
//             ),
//             const SizedBox(
//               width: 18,
//             ),
//             IconButton(
//                 hoverColor: Colors.red.withOpacity(.3),
//                 splashColor: Colors.transparent,
//                 icon: const Icon(
//                   Icons.delete,
//                   color: Colors.red,
//                 ),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (BuildContext context) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: MediaQuery.of(context).size.height > 770
//                               ? 32
//                               : MediaQuery.of(context).size.height > 670
//                                   ? 16
//                                   : 8,
//                           horizontal: MediaQuery.of(context).size.width > 770
//                               ? 16
//                               : MediaQuery.of(context).size.width > 670
//                                   ? 8
//                                   : 4,
//                         ),
//                         child: Center(
//                           child: Card(
//                             elevation: 9,
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(
//                                 color: kPrimaryColor,
//                                 width: 6,
//                               ),
//                               borderRadius: const BorderRadius.all(
//                                 Radius.circular(25),
//                               ),
//                             ),
//                             child: AnimatedContainer(
//                               decoration: const BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(25)),
//                                 color: Colors.white,
//                               ),
//                               duration: const Duration(milliseconds: 200),
//                               height: MediaQuery.of(context).size.height *
//                                   (MediaQuery.of(context).size.height > 770
//                                       ? 0.3
//                                       : MediaQuery.of(context).size.height > 670
//                                           ? 0.36
//                                           : 0.5),
//                               width: 500,
//                               child: AlertDialog(
//                                 elevation: 0,
//                                 title: Row(
//                                   children: const [
//                                     Icon(
//                                       Icons.warning,
//                                       color: Colors.red,
//                                     ),
//                                     SizedBox(
//                                       width: 6,
//                                     ),
//                                     Text('Remove Student'),
//                                   ],
//                                 ),
//                                 content: SingleChildScrollView(
//                                   child: ListBody(
//                                     children: const <Widget>[
//                                       Text(
//                                           'Do you really want to remove this student record?'),
//                                     ],
//                                   ),
//                                 ),
//                                 actions: <Widget>[
//                                   GFButton(
//                                     onPressed: () async {
//                                       // StudentProvider studentProvider =
//                                       //     StudentProvider();
//                                       // await studentProvider
//                                       //     .removeStudent(_user.studentNumber);
//                                       // Navigator.of(context).pop();
//                                       // const SnackBar(
//                                       //   content: Text('Successfully Removed'),
//                                       // );
//                                     },
//                                     child: const Text('Yes'),
//                                     color: Colors.red,
//                                   ),
//                                   const SizedBox(
//                                     width: 9,
//                                   ),
//                                   TextButton(
//                                     child: const Text('Close'),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               //------
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                   //remove from db
//                   // StudentProvider studentProvider = StudentProvider();
//                   // studentProvider.removeStudent(_user.studentNumber);
//                 }),
//           ],
//         )),
//       ],
//     );
//   }

//   @override
//   int get rowCount => students.length;

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get selectedRowCount => _selectedCount;

//   void selectAll(bool checked) {
//     for (final student in students) {
//       student.selected = checked ?? false;
//     }
//     _selectedCount = (checked ?? false) ? students.length : 0;
//     notifyListeners();
//   }
// }

// class StudentDataSourceAsync extends AsyncDataTableSource {
//   StudentDataSourceAsync() {
//     print('StudentDataSourceAsync created.');
//   }

//   StudentDataSourceAsync.empty() {
//     _empty = true;
//     print('StudentDataSourceAsync.empty created');
//   }

//   StudentDataSourceAsync.error() {
//     _errorCounter = 0;
//     print('StudentDataSourceAsync.error created');
//   }

//   bool _empty = false;
//   int _errorCounter;

//   RangeValues _lastNameFilter;

//   RangeValues get lastNameFilter => _lastNameFilter;
//   set lastNameFilter(RangeValues lastnames) {
//     _lastNameFilter = lastnames;
//     refreshDatasource();
//   }
//   final StudentsFakeWebService _repo = StudentssFakeWebService();

//   String _sortColumn = "name";
//   bool _sortAscending = true;

//   void sort(String columnName, bool ascending) {
//     _sortColumn = columnName;
//     _sortAscending = ascending;
//     refreshDatasource();
//   }

//   Future<int> getTotalRecords() {
//     return Future<int>.delayed(
//         const Duration(milliseconds: 0), () => _empty ? 0 : _studentsX3.length);
//   }
// }
