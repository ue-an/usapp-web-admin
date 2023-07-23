import 'package:flutter/material.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/services/firestore_service.dart';

class OtpProvider with ChangeNotifier {
  final _firestoreService = FirestoreService();
  bool _submitValid = false;
  bool _isVerified = false;
  String _email;
  String _password;
  String _repass;
  String _adminName;

  //get
  bool get submitValid => _submitValid;
  bool get isVerified => _isVerified;
  String get email => _email;
  String get password => _password;
  String get repass => _repass;
  String get adminName => _adminName;

  //set
  set changeSubmitValid(bool submitValid) {
    _submitValid = submitValid;
    notifyListeners();
  }

  set changeIsVerified(bool isVerified) {
    _isVerified = isVerified;
    notifyListeners();
  }

  set changeEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set changePassword(String password) {
    _password = password;
    notifyListeners();
  }

  set changeRepass(String repass) {
    _repass = repass;
    notifyListeners();
  }

  set changeAdminName(String adminName) {
    _adminName = adminName;
    notifyListeners();
  }

  //functions
  saveAdmin() async {
    if (_email != null &&
        _password != null &&
        _repass != null &&
        _adminName != null) {
      await _firestoreService.registerWithEmailPassword(
          email: _email, password: _password);
      notifyListeners();
    }
  }

  adminToCollection() {
    var admin = Admin(adminName: _adminName, email: _email);
    _firestoreService.setAdminAccount(admin);
    notifyListeners();
  }
}
