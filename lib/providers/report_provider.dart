import 'package:flutter/material.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/models/thread_messages.dart';
import 'package:web_tut/services/firestore_service.dart';

class ReportProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();

  bool _isApproved = false;
  Report _tappedReport;
  List<Report> _pendingReports = [];
  int _reportsTotal;
  List _selectedReportRequests = [];
  List<Report> _tappedReports = [];

  //getters
  Stream<List<Report>> get reports => firestoreService.getReports();
  Report get tappedReport => _tappedReport;
  List<Report> get pendingReports => _pendingReports;
  int get reportsTotal => _reportsTotal;
  List get selectedReportRequests => _selectedReportRequests;
  List<Report> get tappedReports => _tappedReports;
  //setters
  set changeTappedReport(Report tappedReport) {
    _tappedReport = tappedReport;
    notifyListeners();
  }

  set changePendingReports(List pendingReports) {
    _pendingReports = pendingReports;
    notifyListeners();
  }

  set changeReportsTotal(int reportsTotal) {
    _reportsTotal = reportsTotal;
    notifyListeners();
  }

  set changeSelectedReportRequests(List selectedReportRequests) {
    _selectedReportRequests = selectedReportRequests;
    notifyListeners();
  }

  // addToSelectedList(int index) {
  //   _selectedReportRequests.remove(index);

  //   _selectedReportRequests.add(index);

  //   notifyListeners();
  // }

  // removeFromSelectedList(int index) {
  //   _selectedReportRequests.remove(index);
  //   notifyListeners();
  // }

  //functions
  approveReport() async {
    // var res = await firestoreService.updateReportApproval(tappedReport.thrID);
    // _tappedReports
    _selectedReportRequests.forEach((tapped) async {
      var res = await firestoreService.updateReportApproval(tapped.thrID);
      _isApproved = res;
    });

    // notifyListeners();
  }

  reportThread() async {
    // _tappedReports
    _selectedReportRequests.forEach((tapped) async {
      var res = await firestoreService.updateThreadReportStatus(tapped.thrID);
    });

    // notifyListeners();
  }

  Future<List<ThreadMessage>> viewThreads() async {
    // notifyListeners();
    return await firestoreService.viewThreads(_tappedReport.thrID);
  }

  Future<List<ThreadMessage>> viewThreadReplies() async {
    // notifyListeners();
    return await firestoreService.viewThreadReplies(_tappedReport.thrID);
  }
}
