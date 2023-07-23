class UserAccount {
  String email;
  String studentNumber;

  UserAccount({
    this.email,
    this.studentNumber,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      email: json['email'],
      studentNumber: json['student_number'],
    );
  }
}
