import 'package:flutter/material.dart';
import 'package:web_tut/models/user_activity.dart';
import 'package:web_tut/services/firestore_service.dart';

class UserActivitySearchProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();
  String _searchText = '';

  set changeSearchText(String searchText) {
    _searchText = searchText;
    notifyListeners();
  }

  String get searchText => _searchText;
  Stream<List<UserActivity>> get searchedUserActivities =>
      firestoreService.getUserActivitiesByFilter(_searchText);
}
