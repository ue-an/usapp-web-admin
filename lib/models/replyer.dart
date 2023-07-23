class Replyer {
  String name;
  String section;
  String studentNumber;
  String token;

  Replyer({
    this.name,
    this.section,
    this.studentNumber,
    this.token,
  });

  factory Replyer.fromJson(Map<String, dynamic> json) {
    return Replyer(
      name: json['name'],
      section: json['section'],
      studentNumber: json['student_number'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'section': section,
      'student_number': studentNumber,
      'token': token,
    };
  }
}
