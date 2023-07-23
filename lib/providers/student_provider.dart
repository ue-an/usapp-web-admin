import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/services/firestore_service.dart';

class StudentProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _studentNumber;
  String _lastName;
  String _firstName;
  String _mInitial;
  String _yearLevel;
  String _section;
  String _college;
  String _course;
  final bool _isused = false;
  String _email;
  // mobile 2.0
  Student _tappedStudent;
  List _ids = [];
  //updated details
  String _updStudentNumber;
  String _updLastName;
  String _updFirstName;
  String _updMInitial;
  String _updYearLevel;
  String _updSection;
  String _updCollege;
  String _updCourse;
  List _tapped;

  //getters
  String get studentNumber => _studentNumber;
  String get lastName => _lastName;
  String get firstName => _firstName;
  String get mInitial => _mInitial;
  String get college => _college;
  String get course => _course;
  String get yearLevel => _yearLevel;
  String get section => _section;
  String get email => _email;
  Stream<List<Student>> get students => firestoreService.getStudents();
  //
  List<Student> get studentList => _studentList;
  List<Student> get userList => _userList;
  Student get tappedStudent => _tappedStudent;
  List get ids => _ids;
  //
  String get updStudentNumber => _updStudentNumber;
  String get updLastName => _updLastName;
  String get updFirstName => _updFirstName;
  String get updMInitial => _updMInitial;
  String get updYearLevel => _updYearLevel;
  String get updSection => _updSection;
  String get updCollege => _updCollege;
  String get updCourse => _updCourse;
  List get tapped => _tapped;

  //setters
  set changeStudentNumber(String studentNumber) {
    _studentNumber = studentNumber;
    notifyListeners();
  }

  set changeFirstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  set changeMInitial(String mInitial) {
    _mInitial = mInitial;
    notifyListeners();
  }

  set changeLastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  set changeCourse(String course) {
    _course = course;
    notifyListeners();
  }

  set changeYearLevel(String yearLevel) {
    _yearLevel = yearLevel;
    notifyListeners();
  }

  set changeSection(String section) {
    _section = section;
    notifyListeners();
  }

  set changeCollege(String college) {
    _college = college;
    notifyListeners();
  }

  set changeEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set changeTappedStudent(Student tappedStudent) {
    _tappedStudent = tappedStudent;
    notifyListeners();
  }

  set ids(List ids) {
    _ids = ids;
    notifyListeners();
  }

  set changeTapped(List tapped) {
    _tapped = tapped;
    notifyListeners();
  }

  set updFirstName(String updFirstName) {
    _updFirstName = updFirstName;
    notifyListeners();
  }

  set updMInitial(String updMInitial) {
    _updMInitial = updMInitial;
    notifyListeners();
  }

  set updLastName(String updLastName) {
    _updLastName = updLastName;
    notifyListeners();
  }

  set updCollege(String updCollege) {
    _updCollege = updCollege;
    notifyListeners();
  }

  set updCourse(String updCourse) {
    _updCourse = updCourse;
    notifyListeners();
  }

  set updYearLevel(String updYearLevel) {
    _updYearLevel = updYearLevel;
    notifyListeners();
  }

  set updSection(String updSection) {
    _updSection = updSection;
    notifyListeners();
  }

  //functions
  loadAll(Student student) {
    if (student != null) {
      _studentNumber = student.studentNumber;
    } else {
      _studentNumber = "";
    }
  }

  // saveIdNumber() {
  //   var updatedStudent =
  //       Student(idNumber: _idNumber, name: _name, isused: _isused);
  //   firestoreService.setStudentNumber(updatedStudent);
  // }

  // removeIdNumber(String idNumber) {
  //   firestoreService.removeStudentNumber(idNumber);
  // }

  //new student
  saveStudent() async {
    var updatedStudent = Student(
      studentNumber: _studentNumber,
      lastName: _lastName,
      firstName: _firstName,
      mInitial: _mInitial,
      college: _college,
      course: _course,
      yearLvl: int.parse(_yearLevel),
      section: int.parse(_section),
      isused: _isused,
      isEnabled: true,
      email: _email,
      photo: '',
      about: '',
      deviceToken: '',
    );
    await firestoreService.setStudent(updatedStudent);
  }

  //update details
  changeUpdStudentDetails({
    String updstudentnumber,
    String updfirstname,
    String updminitial,
    String updlastname,
    String updcollege,
    String updcourse,
    String updyearlvl,
    String updsection,
  }) {
    _updStudentNumber = updstudentnumber;
    _updFirstName = updfirstname;
    _updMInitial = updminitial;
    _updLastName = updlastname;
    _updCollege = updcollege;
    _updCourse = updcourse;
    _updYearLevel = updyearlvl;
    _updSection = updsection;
  }

  editStudentDetails() async {
    await firestoreService.updateStudentDetails(
      updstudentnumber: _tapped[0],
      updfirstname: _updFirstName ?? _tapped[2],
      updminitial: _updMInitial ?? _tapped[3],
      updlastname: _updLastName ?? _tapped[4],
      updcollege: _updCollege ?? _tapped[8],
      updcourse: _updCourse ?? _tapped[5],
      updyearlvl: int.parse(_updYearLevel ?? _tapped[6]),
      updsection: int.parse(_updSection ?? _tapped[7]),
    );
  }

  removeStudent(String studentNumber) async {
    await firestoreService.removeStudent(studentNumber);
  }

  //---
  List _studentList = <Student>[];
  Future<List<Student>> fetchData() async {
    _studentList = await firestoreService.waitStudents();
    notifyListeners();
    return firestoreService.waitStudents();
  }

  List _userList = <Student>[];
  Future<List<Student>> fetchUsers() async {
    _studentList = await firestoreService.waitUsers();
    notifyListeners();
    return firestoreService.waitUsers();
  }
}
