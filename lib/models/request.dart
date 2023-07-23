class Request {
  String currEmail;
  String currName;
  String currCollege;
  String reqFname;
  String reqLname;
  String reqMinitial;
  String reqSection;
  bool isAccepted;
  bool isSent;

  Request({
    this.currEmail,
    this.currName,
    this.currCollege,
    this.reqFname,
    this.reqLname,
    this.reqMinitial,
    this.reqSection,
    this.isAccepted,
    this.isSent,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      currEmail: json['current_email'],
      currName: json['current_name'],
      currCollege: json['current_college'],
      reqFname: json['req_first_name'],
      reqLname: json['req_last_name'],
      reqMinitial: json['req_middle_initial'],
      reqSection: json['req_section'],
      isAccepted: json['is_accepted'],
      isSent: json['is_sent'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_email': currEmail,
      'current_name': currName,
      'current_college': currCollege,
      'req_first_name': reqFname,
      'req_last_name': reqLname,
      'req_middle_initial': reqMinitial,
      'req_section': reqSection,
      'is_accepted': isAccepted,
      'is_sent': isSent,
    };
  }
}
