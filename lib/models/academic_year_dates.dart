import 'package:cloud_firestore/cloud_firestore.dart';

class AcademicYearDates {
  final Timestamp ayEnd;
  final Timestamp ayStart;
  final Timestamp enrollDate;
  final int currentYear;
  final int nextYear;

  AcademicYearDates({
    this.ayEnd,
    this.ayStart,
    this.enrollDate,
    this.currentYear,
    this.nextYear,
  });

  factory AcademicYearDates.fromJson(Map<String, dynamic> json) {
    return AcademicYearDates(
      ayEnd: json['ay_end'],
      ayStart: json['ay_start'],
      enrollDate: json['enrollment_date'],
      currentYear: json['current_year'],
      nextYear: json['next_year'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ay_end': ayEnd,
      'ay_start': ayStart,
      'enrollment_date': enrollDate,
      'current_year': currentYear,
      'next_year': nextYear,
    };
  }
}
