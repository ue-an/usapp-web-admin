import 'package:flutter/cupertino.dart';
import 'package:web_tut/models/admin_activity.dart';
import 'package:web_tut/services/firestore_service.dart';

class AdminActivitySearchProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();
  String _searchText = '';

  set changeSearchText(String searchText) {
    _searchText = searchText;
    notifyListeners();
  }

  String get searchText => _searchText;
  Stream<List<AdminActivity>> get searchedAdminActivities =>
      // firestoreService.getUserActivitiesByFilter(_searchText);
      firestoreService.getAdminActivitiesByFilter(_searchText);
}
