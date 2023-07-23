import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:web_tut/models/student.dart';
import 'package:web_tut/services/firestore_service.dart';

class UserDataNotifier2 with ChangeNotifier {
  UserDataNotifier2() {
    fetchData();
  }
  FirestoreService firestoreService = FirestoreService();

  List<Student> get userModel => _userModel;
  //stream
  Stream<List<Student>> get students => firestoreService.getStudents();

  // SORT COLUMN INDEX...

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  // SORT ASCENDING....

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  // -------------------------------------- INTERNALS --------------------------------------------

  List _userModel = <Student>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future fetchData() async {
    _userModel = await firestoreService.waitStudents();
    notifyListeners();
    return firestoreService.waitStudents();
  }
}
