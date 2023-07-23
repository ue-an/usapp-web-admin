import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/services/firestore_service.dart';

class AYDatesProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();

  int _pickedCurrentYear;
  int _pickedNextYear;
  DateTime _pickedAYstartDate;
  DateTime _pickedAYendDate;
  DateTime _pickedEnrollDate;

  //get
  int get pickedCurrentYear => _pickedCurrentYear;
  int get pickedNextYear => _pickedNextYear;
  DateTime get pickedAYstartDate => _pickedAYstartDate;
  DateTime get pickedAYendDate => _pickedAYendDate;
  DateTime get pickedEnrollDate => _pickedEnrollDate;

  //set
  set changePickedCurrentYear(int pickedCurrentYear) {
    _pickedCurrentYear = pickedCurrentYear;
  }

  set changePickedNextYear(int pickedNextYear) {
    _pickedNextYear = pickedNextYear;
  }

  //PICKED
  set changePickedAYstartDate(DateTime pickedAYstartDate) {
    _pickedAYstartDate = pickedAYstartDate;
    // notifyListeners();
  }

  set changePickedAYendDate(DateTime pickedAYendDate) {
    _pickedAYendDate = pickedAYendDate;
    // notifyListeners();
  }

  set changePickedEnrollDate(DateTime pickedEnrollDate) {
    _pickedEnrollDate = pickedEnrollDate;
    // notifyListeners();
  }

  //functions
  setAYstartYear() async {
    await firestoreService.updateAYstartYear(_pickedCurrentYear);
  }

  setAYendYear() async {
    await firestoreService.updateAYendYear(_pickedNextYear);
  }

  setAYstartSem() async {
    await firestoreService
        .updateAYstartSem(Timestamp.fromDate(_pickedAYstartDate));
  }

  setAYendSem() async {
    await firestoreService.updateAYendSem(Timestamp.fromDate(_pickedAYendDate));
  }

  setEnrollDate() async {
    await firestoreService
        .updateEnrollDate(Timestamp.fromDate(_pickedEnrollDate));
  }
}
