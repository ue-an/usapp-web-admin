import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:web_tut/models/replyer.dart';
import 'package:web_tut/models/thread_reply.dart';
import 'package:web_tut/services/firestore_service.dart';

class ThreadReplyProvider with ChangeNotifier {
  FirestoreService firestoreService = FirestoreService();
  var uuid = Uuid();
  String _threadID = '';
  String _replyForumID = '';
  String _thrMessageID = '';
  String _replyForumCommentID = '';
  String _replyID;
  String _content;
  Replyer _replyer;
  String _name;
  String _replyPhoto;
  String _section;
  String _studentNumber;

  //setters
  changeThreadID(String threadID) {
    _threadID = threadID;
    // notifyListeners();
  }

  changeReplyForumID(String replyForumID) {
    _replyForumID = replyForumID;
    // notifyListeners();
  }

  set changethrMessageID(String thrMessageID) {
    _thrMessageID = thrMessageID;
    notifyListeners();
  }

  set changeReplyForumCommentID(String replyForumCommentID) {
    _replyForumCommentID = replyForumCommentID;
    notifyListeners();
  }

  set changeReplyID(String replyID) {
    _replyID = replyID;
    notifyListeners();
  }

  set changeContent(String content) {
    _content = content;
    notifyListeners();
  }

  set changeReplyer(Replyer replyer) {
    _replyer = replyer;
    notifyListeners();
  }

  set changeStudentNumber(String studentNumber) {
    _studentNumber = studentNumber;
    notifyListeners();
  }

  set changeReplyPhoto(String replyPhoto) {
    _replyPhoto = replyPhoto;
    notifyListeners();
  }

  //getters
  String get thrMessageID => _thrMessageID ?? '';
  String get content => _content;
  Replyer get replyer => _replyer;
  String get threadID => _threadID;
  String get replyForumID => _replyForumID;
  String get replyForumCommentID => _replyForumCommentID;
  Stream<List<ThreadReply>> get getThreadReplyy =>
      firestoreService.getThreadReplyy(_threadID, _thrMessageID);
}
