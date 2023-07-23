import 'package:cloud_firestore/cloud_firestore.dart';

class Thread {
  final String id;
  final String title;
  final int msgSent;
  final String studID;
  // final String date;
  //-------------
  final Timestamp tSdate;
  final String college;
  final String creatorName;
  final String creatorSection;
  final String authorToken;
  final String description;
  final bool isDeleted;
  final bool isReported;
  final List likers;
  final List likersTokens;
  final List reporters;

  const Thread({
    this.id,
    this.title,
    this.msgSent,
    // required this.date,
    this.studID,
    this.college,
    this.creatorName,
    this.creatorSection,
    //-------------
    this.tSdate,
    this.authorToken,
    this.description,
    this.isDeleted,
    this.isReported,
    this.likers,
    this.reporters,
    this.likersTokens,
  });

  //2.0
  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      id: json['thread_id'],
      title: json['title'],
      msgSent: json['msg_sent'],
      // date: json['create_date'],
      studID: json['thread_creator'],
      college: json['college'],
      creatorName: json['creator_name'],
      creatorSection: json['creator_section'],
      //------------------
      tSdate: json['create_date'],
      authorToken: json['author_token'],
      description: json['description'],
      isDeleted: json['is_deleted_by_owner'],
      isReported: json['is_reported'],
      likers: json['likers'],
      likersTokens: json['likers_tokens'],
      reporters: json['reporters'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'create_date': date,
      'msg_sent': msgSent,
      'thread_creator': studID,
      'thread_id': id,
      'title': title,
      'creator_name': creatorName,
      'college': college,
      'creator_section': creatorSection,
      'create_date': tSdate,
      'author_token': authorToken,
      'description': description,
      'is_deleted_by_owner': isDeleted,
      'is_reported': isReported,
      'likers': likers,
      'likers_tokens': likersTokens,
      'reporters': reporters,
    };
  }
}
