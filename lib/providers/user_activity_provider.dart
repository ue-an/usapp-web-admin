import 'package:flutter/cupertino.dart';
import 'package:web_tut/models/user_activity.dart';

class UserActivityProvider with ChangeNotifier {
  List<UserActivity> _userActivitiesResult = [];
  List<UserActivity> _filteredAcivities = [];
  bool _isGenerated = false;

  //set
  set userActivitiesResult(List<UserActivity> userActivitiesResult) {
    _userActivitiesResult = userActivitiesResult;
    // notifyListeners();
  }

  //get
  List get userActivitiesResult => _userActivitiesResult;
  List get filteredActivities => _filteredAcivities;
  bool get isGenerated => _isGenerated;

  //functions
  changeUserActivitiesResult(List<UserActivity> userActivitiesResult) {
    _userActivitiesResult = userActivitiesResult;
  }

  changeFilteredActivities(List<UserActivity> filteredActivities) {
    _filteredAcivities = filteredActivities;
  }

  generatedPDF(bool isGenerated) {
    _isGenerated = isGenerated;
  }
}
