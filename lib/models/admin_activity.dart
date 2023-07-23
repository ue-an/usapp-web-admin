import 'package:cloud_firestore/cloud_firestore.dart';

class AdminActivity {
  String id;
  String name;
  String activityTitle;
  String email;
  Timestamp date;

  AdminActivity({
    this.id,
    this.name,
    this.activityTitle,
    this.email,
    this.date,
  });

  factory AdminActivity.fromJson(Map<String, dynamic> json) {
    return AdminActivity(
      id: json['id'],
      name: json['name'],
      activityTitle: json['activity_title'],
      email: json['email'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'activity_title': activityTitle,
      'email': email,
      'date': date,
    };
  }
}
