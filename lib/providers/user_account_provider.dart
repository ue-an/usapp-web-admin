import 'package:flutter/material.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/services/firestore_service.dart';

class UserAccountProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();

  Student _tappedActiveAccount;
  Student _tappedDisabledAccount;

  //get
  Student get tappedActiveAccount => _tappedActiveAccount;
  Student get tappedDisabledAccount => _tappedDisabledAccount;

  //set
  set changeTappedActiveAccount(Student tappedActiveAccount) {
    _tappedActiveAccount = tappedActiveAccount;
    notifyListeners();
  }

  set changeTappedDisabledAccount(Student tappedDisabledAccount) {
    _tappedDisabledAccount = tappedDisabledAccount;
    notifyListeners();
  }

  //function
  //user accounts (mobile)
  disableUserAccount() async {
    await firestoreService
        .disableUserAccount(_tappedActiveAccount.studentNumber);
  }

  enableUserAccount() async {
    await firestoreService
        .enableUserAccount(_tappedDisabledAccount.studentNumber);
  }
}
