import 'package:flutter/material.dart';

class UserDataNotifier with ChangeNotifier {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  // int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _rowsPerPage = 10;
  UserDataNotifier() {
    // fetchData();
  }

  // List<Student> get userModel => _userModel;

  // SORT COLUMN INDEX...

  int get sortColumnIndex => _sortColumnIndex;

  set changeSortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  // SORT ASCENDING....

  bool get sortAscending => _sortAscending;

  set changeSortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  // -------------------------------------- INTERNALS --------------------------------------------

  // var _userModel = <Student>[];

  // Future<void> fetchData() async {
  //   _userModel = await DataTableApi.fetchData();
  //   notifyListeners();
  // }
}
