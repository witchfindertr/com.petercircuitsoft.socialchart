import 'package:cloud_firestore/cloud_firestore.dart';

class ModelInsightCardList {
  const ModelInsightCardList({
    required this.cardId,
    required this.createdAt,
  });
  final String cardId; //user Id
  final Timestamp createdAt; //creation time

  ModelInsightCardList.fromJson(Map<String, Object?> json)
      : this(
          cardId: json['cardId'] as String,
          createdAt: json['createdAt'] as Timestamp,
        );
  Map<String, Object?> toJson() {
    return {
      'cardId': cardId,
      'createdAt': createdAt,
    };
  }
}
