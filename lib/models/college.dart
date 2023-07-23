import 'dart:html';

class College {
  String collegeName;
  String campus;
  String collegeID;
  List courses;

  College({
    this.campus,
    this.collegeName,
    this.collegeID,
    this.courses,
  });

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      collegeID: json['collegeID'],
      campus: json['campus'],
      collegeName: json['college_name'],
      courses: json['courses'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'collegeID': collegeID,
      'campus': campus,
      'college_name': collegeName,
      'courses': courses,
    };
  }
}
