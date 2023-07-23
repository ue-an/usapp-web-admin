import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_tut/models/replyer.dart';

class ThreadReply {
  Replyer replyBy;
  String replyID;
  String content;
  String commentID;
  Timestamp replyDate;
  String photo;
  String file;

  ThreadReply({
    this.content,
    this.replyID,
    this.replyBy,
    this.commentID,
    this.replyDate,
    this.photo,
    this.file,
  });

  factory ThreadReply.fromJson(Map<String, dynamic> json) {
    return ThreadReply(
      commentID: json['comment_id'],
      replyID: json['reply_id'],
      content: json['content'],
      photo: json['reply_photo'],
      file: json['reply_file'],
      replyBy: Replyer.fromJson(json['reply_by']),
      replyDate: json['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment_id': commentID,
      'reply_id': replyID,
      'content': content,
      'reply_photo': photo,
      'reply_file': file,
      'reply_by': replyBy.toMap(),
      'date': replyDate,
    };
  }
}
