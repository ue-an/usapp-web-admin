import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:web_tut/models/admin_activity.dart';
import 'package:web_tut/services/firestore_service.dart';

class AdminActivityProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var uuid = Uuid();
  String _name;
  Timestamp _date;
  String _activityTitle;

  //get
  String get name => _name;
  Timestamp get date => _date;
  String get activityTitle => _activityTitle;

  //set

  set changeName(String name) {
    _name = name;
    notifyListeners();
  }

  set changeDate(DateTime date) {
    Timestamp converted = Timestamp.fromDate(date);
    _date = converted;
    notifyListeners();
  }

  set changeActivityTitle(String activityTitle) {
    _activityTitle = activityTitle;
    notifyListeners();
  }

  //functions
  addActivity() async {
    //add admin activity to firebase
    String email = firebaseAuth.currentUser.email;
    var updatedAdminActivity = AdminActivity(
      name: _name,
      email: email,
      id: email + '_' + uuid.v4(),
      activityTitle: _activityTitle,
      date: _date,
    );
    firestoreService.setAdminActivity(updatedAdminActivity);
  }

  List<AdminActivity> _adminActivitiesResult = [];
  List<AdminActivity> _filteredAcivities = [];
  bool _isGenerated = false;

//set
  set changeadminActivitiesResult(List<AdminActivity> adminActivitiesResult) {
    _adminActivitiesResult = adminActivitiesResult;
    notifyListeners();
  }

  set changefilteredActivities(List<AdminActivity> filteredActivities) {
    _filteredAcivities = filteredActivities;
    notifyListeners();
  }

//get
  List<AdminActivity> get adminActivitiesResult => _adminActivitiesResult;
  List<AdminActivity> get filteredActivities => _filteredAcivities;
  bool get isGenerated => _isGenerated;

//functions
  // changeAdminActivitiesResult(List<AdminActivity> adminActivitiesResult) {
  //   _adminActivitiesResult = adminActivitiesResult;
  // }

  // changeFilteredActivities(List<AdminActivity> filteredActivities) {
  //   _filteredAcivities = filteredActivities;
  // }

  generatedPDF(bool isGenerated) {
    _isGenerated = isGenerated;
  }
}
