import 'package:flutter/material.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/services/firestore_service.dart';

class ThreadProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  List<Thread> get threadList => _threadList;

  List _threadList = <Thread>[];
  Future<List<Thread>> fetchData() async {
    _threadList = await firestoreService.waitThreads();
    notifyListeners();
    return firestoreService.waitThreads();
  }
}
