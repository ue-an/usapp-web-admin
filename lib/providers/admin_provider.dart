import 'dart:html';

import 'package:flutter/material.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/services/firestore_service.dart';

class AdminProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();

  String _adminName = '';
  String _adminEmail = '';
  String _adminPassword = '';

  //get
  String get adminName => _adminName;
  String get adminEmail => _adminEmail;
  String get adminPassword => _adminPassword;

  //set
  set changeAdminName(String adminName) {
    _adminName = adminName;
    notifyListeners();
  }

  set changeAdminEmail(String adminEmail) {
    _adminEmail = adminEmail;
    notifyListeners();
  }

  set changeAdminPassword(String adminPassword) {
    _adminPassword = adminPassword;
    notifyListeners();
  }

  //functions
  registerAdmin() async {
    await firestoreService.registerWithEmailPassword(
        email: _adminEmail, password: _adminPassword);
  }

  createAdminAccount() async {
    var updatedAdmin = Admin(
      adminName: _adminName,
      email: _adminEmail,
      usertype: 'admin',
      isEnabled: true,
    );
    firestoreService.setAdminAccount(updatedAdmin);
  }

  enableAdmin(String email) async {
    await firestoreService.enableAdmin(email);
  }

  disableAdmin(String email) async {
    await firestoreService.disableAdmin(email);
  }
}
