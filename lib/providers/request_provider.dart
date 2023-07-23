import 'package:flutter/material.dart';
import 'package:web_tut/models/request.dart';
import 'package:web_tut/services/firestore_service.dart';

class RequestProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();

  bool _isAccepted = false;
  Request _tappedRequest;
  String _tappedEmail;
  List<Request> _pendingRequests = [];
  int _requestsTotal;

  //get
  Request get tappedRequest => _tappedRequest;
  List<Request> get pendingRequests => _pendingRequests;
  int get requestsTotal => _requestsTotal;
  Stream<List<Request>> get requests => firestoreService.getRequests();
  //set
  set changeTappedEmail(String currEmail) {
    _tappedEmail = currEmail;
    // notifyListeners();
  }

  set changeRequestsTotal(int requestsTotal) {
    _requestsTotal = requestsTotal;
    // notifyListeners();
  }

  set changeTappedRequest(Request tappedRequest) {
    _tappedRequest = tappedRequest;
    notifyListeners();
  }

  //functions
  acceptRequest() async {
    var res = await firestoreService.updateRequestStatus(_tappedEmail);
    _isAccepted = res;
    notifyListeners();
  }
}
