import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:web_tut/models/college.dart';
import 'package:web_tut/services/firestore_service.dart';

class CollegeProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _campus;
  String _collegeID;
  String _collegeName;
  var uuid = const Uuid();
  List _collegeNames = [];
  String _courseName;
  String _newCourse;

  //getters
  String get campus => _campus;
  String get collegeID => _collegeID;
  String get collegeName => _collegeName;
  Stream<List<College>> get colleges => firestoreService.getColleges();
  List get collegeNames => _collegeNames;
  //
  List<College> get collegeList => _collegeList;
  String get courseName => _courseName;
  String get newCourse => _newCourse;

  //setters
  set changeCampus(String campus) {
    _campus = campus;
    notifyListeners();
  }

  set changeCollegename(String collegeName) {
    _collegeName = collegeName;
    notifyListeners();
  }

  set collegeNames(List collegeNames) {
    _collegeNames = collegeNames;
    notifyListeners();
  }

  set changeCourseName(String courseName) {
    _courseName = courseName;
    notifyListeners();
  }

  set changeNewCourse(String newCourse) {
    _newCourse = newCourse;
    notifyListeners();
  }

  //functions
  loadAll(College college) {
    _campus = college.campus;
    _collegeName = college.collegeName;
    _collegeID = college.collegeID;
  }

  saveCollege() async {
    var updatedCollege = College(
      campus: _campus.toUpperCase(),
      collegeName: _collegeName.toUpperCase(),
      // collegeID: uuid.v1().toString(),
      collegeID: _collegeName.toUpperCase(),
      courses: [_courseName.toUpperCase()],
    );

    await firestoreService.setCollege(updatedCollege);
  }

  removeCollege(String collegeID) {
    firestoreService.removeCollege(collegeID);
  }

  //colleges 'future' results instead of stream
  List _collegeList = <College>[];
  Future<List<College>> fetchData() async {
    _collegeList = await firestoreService.waitColleges();
    notifyListeners();
    return firestoreService.waitColleges();
  }

  addCourse() async {
    await firestoreService.updateCollegeCourses(_collegeNames[0], _newCourse);
  }

  addCourseFromCourse() async {
    await firestoreService.updateCollegeCourses(_collegeName, _newCourse);
  }

  removeCourseFromCourse(String college, String course) async {
    await firestoreService.removeCourseInCollege(college, course);
  }
}
