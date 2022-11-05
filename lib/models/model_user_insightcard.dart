import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class InsightCardModel {
  InsightCardModel({
    required this.createdAt,
    required this.chartId,
    required this.cardType,
    required this.author,
    required this.userText,
    this.linkPreviewData,
    this.replyCount = 0,
    this.pinCount = 0,
  });
  final Timestamp createdAt; //creation time
  final String chartId;
  final String cardType;
  final DocumentReference author; //userReference
  final String userText;
  final LinkPreviewData? linkPreviewData;
  final int replyCount;
  final int pinCount;

  InsightCardModel.fromJson(Map<String, dynamic?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          chartId: json['chartId']! as String,
          cardType: json['cardType'] as String,
          author: json['author'] as DocumentReference,
          userText: json['userText'] as String,
          linkPreviewData: json['linkPreviewData'] != null
              ? LinkPreviewData.fromJson(json['linkPreviewData'])
              : null,
          replyCount: json['replyCount'] as int,
          pinCount: json['pinCount'] as int,
        );
  Map<String, dynamic?> toJson() {
    return {
      'createdAt': createdAt,
      'chartId': chartId,
      'cardType': cardType,
      'author': author,
      'userText': userText,
      'linkPreviewData': linkPreviewData?.toJson(),
      'replyCount': replyCount,
      'pinCount': pinCount,
    };
  }
}

class LinkPreviewData {
  LinkPreviewData({
    this.url,
    this.image,
    this.title,
    this.description,
  });
  final String? url;
  final String? image;
  final String? title;
  final String? description;

  LinkPreviewData.fromJson(Map<String, dynamic> json)
      : this(
            description: json['description'],
            image: json['image'],
            title: json['title'],
            url: json['url']);

  Map<String, dynamic> toJson() => {
        "url": url,
        "image": image,
        "title": title,
        "description": description,
      };
}
