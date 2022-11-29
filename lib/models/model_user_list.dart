import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUserList {
  const ModelUserList({
    required this.userId,
    required this.createdAt,
  });
  final String userId; //user Id
  final Timestamp createdAt; //creation time

  ModelUserList.fromJson(Map<String, Object?> json)
      : this(
          userId: json['userId'] as String,
          createdAt: json['createdAt'] as Timestamp,
        );
  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
