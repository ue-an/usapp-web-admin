import 'dart:html';

class User {
  final String userID;
  final String studNum;
  final String fullname;
  final String email;
  final String username;
  final String college;
  final String course;
  final String yearSec;

  User({
    this.userID,
    this.studNum,
    this.fullname,
    this.email,
    this.username,
    this.course,
    this.college,
    this.yearSec,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userID: json['user_id'],
        studNum: json['stud_number'],
        fullname: json['fullname'],
        email: json['email'],
        username: json['username'],
        course: json['course'],
        college: json['college'],
        yearSec: json['year_section']);
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userID,
      'stud_number': studNum,
      'fullname': fullname,
      'email': email,
      'username': username,
      'college': college,
      'course': course,
      'year_section': yearSec,
    };
  }
}
