import 'package:cloud_firestore/cloud_firestore.dart';

class InsightCardModel {
  InsightCardModel({
    required this.createdAt,
    required this.chartId,
    required this.cardType,
    required this.author,
    required this.userText,
    this.linkPreviewData,
    this.commentCounter = 0,
    this.scrapCounter = 0,
    this.likeCounter = 0,
  });
  final Timestamp createdAt; //creation time
  final String chartId;
  final String cardType;
  final DocumentReference author; //userReference
  final String userText;
  final LinkPreviewData? linkPreviewData;
  final int? commentCounter;
  final int? scrapCounter;
  final int? likeCounter;

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
          commentCounter: json['commentCount'] as int?,
          scrapCounter: json['scrapCounter'] as int?,
          likeCounter: json['likeCounter'] as int?,
        );
  Map<String, dynamic?> toJson() {
    return {
      'createdAt': createdAt,
      'chartId': chartId,
      'cardType': cardType,
      'author': author,
      'userText': userText,
      'linkPreviewData': linkPreviewData?.toJson(),
      'commentCount': commentCounter,
      'scrapCounter': scrapCounter,
      'likeCounter': likeCounter,
    };
  }
}

//for the subcollection
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
