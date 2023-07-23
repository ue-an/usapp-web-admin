import 'package:flutter/cupertino.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/services/firestore_service.dart';

class SFDataSearchProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();
  String _searchText = '';

  set changeSearchText(String searchText) {
    _searchText = searchText;
    notifyListeners();
  }

  String get searchText => _searchText;
  Stream<List<Student>> get searchedStudents =>
      firestoreService.searchStudents(_searchText);
}
