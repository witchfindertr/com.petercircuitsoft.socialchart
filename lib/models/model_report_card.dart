import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchart/screens/modal_screen_report/modal_screen_report_controller.dart';

class ModelReportCard {
  const ModelReportCard({
    required this.createdAt,
    required this.cardId,
    required this.reportIndex,
    required this.reporterId,
    this.extraUserText,
  });
  final Timestamp createdAt; //creation time
  final int reportIndex;
  final String cardId;
  final String reporterId;
  final String? extraUserText;

  ModelReportCard.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          cardId: json['cardId']! as String,
          reporterId: json['reporterId']! as String,
          reportIndex: json['reportItem']! as int,
          extraUserText: json['extraUserText'] as String?,
        );
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'cardId': cardId,
      'reporterId': reporterId,
      'reportItem': reportIndex,
      'extraUserText': extraUserText,
    };
  }
}
