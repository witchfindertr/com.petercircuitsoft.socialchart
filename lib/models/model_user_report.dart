import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUserReport {
  const ModelUserReport({
    required this.userEmail,
    required this.userMessage,
    required this.createdAt,
    this.isReplied,
    this.replyMessage,
  });
  final String userEmail; //user email
  final String userMessage; // user text reported
  final Timestamp createdAt; //creation time
  final bool? isReplied;
  final String? replyMessage;
  ModelUserReport.fromJson(Map<String, Object?> json)
      : this(
          userMessage: json['userMessage']! as String,
          createdAt: json['createdAt']! as Timestamp,
          userEmail: json['userEmail']! as String,
          isReplied: json['isReplied']! as bool,
          replyMessage: json['replyMessage'] as String,
        );
  Map<String, Object?> toJson() {
    return {
      'userMessage': userMessage,
      'userEmail': userEmail,
      'createdAt': createdAt,
      'isReplied': isReplied,
      'replyMessage': replyMessage,
    };
  }
}
