import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_tut/models/request.dart';

class ThreadMessage {
  final String messageID;
  final String messageContent;
  final Timestamp messageDate;
  final String messageSenderID;
  final String senderName;
  final String senderPhoto;
  final String senderYearSec;
  final String senderToken;
  final String threadMessagePhoto;

  ThreadMessage({
    this.messageID,
    this.messageContent,
    this.messageDate,
    this.messageSenderID,
    this.senderName,
    this.senderPhoto,
    this.senderYearSec,
    this.senderToken,
    this.threadMessagePhoto,
  });

  factory ThreadMessage.fromJson(Map<String, dynamic> json) {
    return ThreadMessage(
      messageID: json['thread_message_id'],
      messageContent: json['thread_message_content'],
      messageDate: json['thread_message_date'],
      messageSenderID: json['thread_message_sender_id'],
      senderName: json['thread_sender_name'],
      senderPhoto: json['thread_sender_photo'],
      senderYearSec: json['thread_sender_year_section'],
      senderToken: json['sender_token'],
      threadMessagePhoto: json['thread_message_photo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'thread_message_id': messageID,
      'thread_message_content': messageContent,
      'thread_message_date': messageDate,
      'thread_message_sender_id': messageSenderID,
      'thread_sender_name': senderName,
      'thread_sender_photo': senderPhoto,
      'thread_sender_year_section': senderYearSec,
      'sender_token': senderToken,
      'thread_message_photo': threadMessagePhoto,
    };
  }
}
