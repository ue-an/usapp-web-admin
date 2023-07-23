import 'package:cloud_firestore/cloud_firestore.dart';

class UserActivity {
  Timestamp date;
  String title;
  String owner;
  String activityID;
  String comment;

  UserActivity({
    this.date,
    this.title,
    this.owner,
    this.activityID,
    this.comment,
  });

  factory UserActivity.fromJson(Map<String, dynamic> json) {
    return UserActivity(
      date: json['date'],
      title: json['title'],
      owner: json['activity_owner'],
      activityID: json['activity_id'],
      comment: json['comment'],
    );
  }
}
