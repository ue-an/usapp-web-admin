import 'package:flutter/cupertino.dart';
import 'package:web_tut/models/admin_activity.dart';
import 'package:web_tut/services/firestore_service.dart';

class LogTypeProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();
  String _selectedLogtype = 'Administrator';

  set changeSelectedLogtype(String selectedLogType) {
    _selectedLogtype = selectedLogType;
    notifyListeners();
  }

  String get selectedLogtype => _selectedLogtype;
  // Stream<List<AdminActivity>> get searchedAdminActivities =>
  //     // firestoreService.getUserActivitiesByFilter(_searchText);
  //     firestoreService.getAdminActivitiesByFilter(_searchText);
}
