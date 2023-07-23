class Admin {
  String email;
  String adminName;
  String usertype;
  bool isEnabled;

  Admin({
    this.email,
    this.adminName,
    this.usertype,
    this.isEnabled,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      adminName: json['admin_name'],
      email: json['admin_email'],
      usertype: json['usertype'],
      isEnabled: json['is_enabled'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'admin_name': adminName,
      'admin_email': email,
      'usertype': usertype,
      'is_enabled': isEnabled,
    };
  }
}
