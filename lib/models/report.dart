import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final bool isAppoved;
  final List reasons;
  final Timestamp reportDate;
  final List reporters;
  final String thrCreatorID;
  final String thrCreatorName;
  final String thrID;
  final String thrTitle;
  final int reportCount;

  const Report({
    this.isAppoved,
    this.reasons,
    this.reportDate,
    this.reporters,
    this.thrCreatorID,
    this.thrCreatorName,
    this.thrID,
    this.thrTitle,
    this.reportCount,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      isAppoved: json['is_approved'],
      reasons: json['reasons'],
      reportDate: json['report_date'],
      reporters: json['reporters'],
      thrCreatorID: json['thread_creator_id'],
      thrCreatorName: json['thread_creator_name'],
      thrID: json['thread_id'],
      thrTitle: json['thread_title'],
      reportCount: json['report_count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_approved': isAppoved,
      'reasons': reasons,
      'report_date': reportDate,
      'reporters': reporters,
      'thread_creator_id': thrCreatorID,
      'thread_creator_name': thrCreatorName,
      'thread_id': thrID,
      'thread_title': thrTitle,
      'report_count': reportCount,
    };
  }
}
