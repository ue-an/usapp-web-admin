class Campus {
  String campusName;

  Campus({this.campusName});

  factory Campus.fromJson(Map<String, dynamic> json) {
    return Campus(
      campusName: json['campus_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'campus_name': campusName,
    };
  }
}
