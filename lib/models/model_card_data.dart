import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class CardData {
  CardData({
    required this.createdAt,
    required this.chartId,
    required this.cardType,
    required this.author,
    this.cardMessage,
    this.linkData,
    this.replyCount,
    this.pinCount,
  });
  final Timestamp createdAt; //creation time
  final String chartId;
  final String cardType;
  final DocumentReference author; //userReference
  final String? cardMessage;
  final LinkData? linkData;
  final int? replyCount;
  final int? pinCount;

  CardData.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          chartId: json['chartId']! as String,
          cardType: json['cardType'] as String,
          author: json['author'] as DocumentReference,
          cardMessage: json['cardMessage'] as String?,
          linkData: json['linkData'] as LinkData?,
          replyCount: json['replyCount'] as int?,
          pinCount: json['pinCount'] as int?,
        );
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'chartId': chartId,
      'cardType': cardType,
      'author': author,
      'cardMessage': cardMessage,
      'linkData': linkData,
      'replyCount': replyCount,
      'pinCount': pinCount,
    };
  }
}

class LinkData {
  LinkData({
    required this.url,
    this.image,
    this.title,
    this.description,
  });
  final Url url;
  final Url? image;
  final String? title;
  final String? description;
}
