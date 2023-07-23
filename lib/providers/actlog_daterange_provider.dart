import 'package:flutter/material.dart';
import 'package:web_tut/services/firestore_service.dart';

class ActivityLogDateRangeProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();
  String _start;
  String _end;
  DateTime _startDt;
  DateTime _endDt;

  //getters
  String get start => _start;
  String get end => _end;
  DateTime get startDt => _startDt;
  DateTime get endDt => _endDt;

  //setters
  set changeStart(String start) {
    _start = start;
  }

  set changeEnd(String end) {
    _end = end;
  }

  set changeStartDt(DateTime startDt) {
    _startDt = startDt;
  }

  set changeEndDt(DateTime endDt) {
    _endDt = endDt;
  }
}
