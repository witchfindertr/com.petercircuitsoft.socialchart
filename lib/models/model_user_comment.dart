import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUserComment {
  const ModelUserComment({
    required this.author,
    required this.comment,
    required this.createdAt,
    required this.commentCreatedAt,
    this.isDeleted = false,
    this.deletedAt,
  });
  final String author; //user email
  final String comment; // user text reported
  final Timestamp createdAt; //creation time
  final Timestamp commentCreatedAt; //creation time
  final bool? isDeleted;
  final Timestamp? deletedAt;
  ModelUserComment.fromJson(Map<String, Object?> json)
      : this(
          author: json['author']! as String,
          comment: json['comment']! as String,
          createdAt: json['createdAt']! as Timestamp,
          commentCreatedAt: json['commentCreatedAt']! as Timestamp,
          isDeleted: json['isDeleted'] as bool,
          deletedAt: json['deletedAt'] as Timestamp,
        );
  Map<String, Object?> toJson() {
    return {
      'author': author,
      'comment': comment,
      'createdAt': createdAt,
      'commentCreatedAt': commentCreatedAt,
      'isDeleted': isDeleted,
      'deletedAt': deletedAt,
    };
  }
}
