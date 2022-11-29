import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUserNotice {
  const ModelUserNotice({
    required this.authorId,
    required this.createdAt,
    required this.insightCardId,
    this.isChecked = false,
  });
  final String authorId; //user Id
  final Timestamp createdAt; //creation time
  final String insightCardId; //creation time
  final bool isChecked;

  ModelUserNotice.fromJson(Map<String, Object?> json)
      : this(
          authorId: json['authorId'] as String,
          createdAt: json['createdAt'] as Timestamp,
          insightCardId: json['insightCardId'] as String,
          isChecked: json['isChecked'] as bool,
        );
  Map<String, Object?> toJson() {
    return {
      'authorId': authorId,
      'createdAt': createdAt,
      'insightCardId': insightCardId,
      'isChecked': isChecked,
    };
  }
}
