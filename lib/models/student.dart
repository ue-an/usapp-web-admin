import 'package:flutter/material.dart';
import 'package:web_tut/screens/advanced_datatable/adv_home.dart';

class Student {
  final String studentNumber;
  final String lastName;
  final String firstName;
  final String mInitial;
  final String college;
  final String course;
  final int yearLvl;
  final int section;
  final bool isused;
  final String email;
  final String photo;
  final String about;
  final String deviceToken;
  final bool isEnabled;
  bool selected;

  Student({
    this.studentNumber,
    this.lastName,
    this.firstName,
    this.mInitial,
    this.college,
    this.course,
    this.yearLvl,
    this.section,
    this.isused,
    this.email,
    this.photo,
    this.about,
    this.deviceToken,
    this.isEnabled,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentNumber: json['student_number'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      mInitial: json['middle_initial'],
      college: json['college'],
      course: json['course'],
      yearLvl: json['year_level'],
      section: json['section'],
      isused: json['is_used'],
      email: json['email'],
      photo: json['photo_url'],
      about: json['about'],
      deviceToken: json['device_token'],
      isEnabled: json['is_enabled'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'student_number': studentNumber,
      'last_name': lastName,
      'first_name': firstName,
      'middle_initial': mInitial,
      'college': college,
      'course': course,
      'year_level': yearLvl,
      'section': section,
      'is_used': isused,
      'email': email,
      'photo_url': photo,
      'about': about,
      'device_token': deviceToken,
      'is_enabled': isEnabled,
    };
  }
}
