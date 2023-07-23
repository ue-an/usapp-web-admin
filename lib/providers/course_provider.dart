import 'package:flutter/material.dart';
import 'package:web_tut/models/course.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class CourseProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _college;
  String _couresId;
  String _couresName;
  var uuid = const Uuid();
  int _years;
  int _sections;
  List _courseNames;
  int _editYears;
  int _editSections;
  String _editCollege;
  String _editCourse;
  String _editCourseID;

  //getters
  String get college => _college;
  String get courseId => _couresId;
  String get courseName => _couresName;
  Stream<List<Course>> get courses => firestoreService.getCourses();
  //---
  List<Course> get courseList => _courseList;
  int get years => _years;
  int get sections => _sections;
  List get courseNames => _courseNames;
  int get editYears => _editYears;
  int get editSections => _editSections;
  String get editCollege => _editCollege;
  String get editCourse => _editCourse;
  String get editCourseID => _editCourseID;

  //setters
  set changeCollege(String college) {
    _college = college;
    notifyListeners();
  }

  set changeCourseName(String courseName) {
    _couresName = courseName;
    notifyListeners();
  }

  set changeYears(int years) {
    _years = years;
    notifyListeners();
  }

  set changeSections(int sections) {
    _sections = sections;
    notifyListeners();
  }

  set changeCourseNames(List courseNames) {
    _courseNames = courseNames;
    notifyListeners();
  }

  set editYears(int editYears) {
    _editYears = editYears;
    notifyListeners();
  }

  set editSections(int editSections) {
    _editSections = editSections;
    notifyListeners();
  }

  set editCollege(String editCollege) {
    _editCollege = editCollege;
    notifyListeners();
  }

  set editCourse(String editCourse) {
    _editCourse = editCourse;
    notifyListeners();
  }

  set editCourseID(String editCourseID) {
    _editCourseID = editCourseID;
    notifyListeners();
  }

  //functions
  loadAll(Course course) {
    _college = course.college;
    _couresId = course.courseId;
    _couresName = course.courseName;
  }

  saveCourse() async {
    var updatedCourse = Course(
      college: _college.toUpperCase(),
      courseId: _couresName.toUpperCase(),
      courseName: _couresName.toUpperCase(),
      years: _years,
      sections: _sections,
    );
    await firestoreService.setCourse(updatedCourse);
  }

  removeCourse(String courseId) {
    firestoreService.removeCourse(courseId);
  }

  updateCourse() async {
    // if ((_editYears != null || _editYears != 0) &&
    //     (_editSections != null || _editSections != 0)) {

    await firestoreService.updateCourse(
        _editCourseID, _editYears, _editSections);
    // }
  }

  //----
  List _courseList = <Course>[];
  Future<List<Course>> fetchData() async {
    _courseList = await firestoreService.waitCourses();
    notifyListeners();
    return firestoreService.waitCourses();
  }
}
