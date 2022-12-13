import 'package:cloud_firestore/cloud_firestore.dart';

class ModelInsightCard {
  ModelInsightCard({
    required this.createdAt,
    this.deletedAt,
    required this.chartId,
    required this.cardType,
    required this.author,
    required this.userText,
    this.linkPreviewData,
    this.isDeleted = false,
    this.commentCounter,
    this.scrapCounter,
    this.likeCounter,
    this.dislikeCounter,
  });
  final Timestamp createdAt; //creation time
  final Timestamp? deletedAt; //creation time
  final String chartId;
  final String cardType;
  final DocumentReference author; //userReference
  final String userText;
  final LinkPreviewData? linkPreviewData;
  final bool? isDeleted;
  final int? commentCounter;
  final int? scrapCounter;
  final int? likeCounter;
  final int? dislikeCounter;

  ModelInsightCard.fromJson(Map<String, dynamic?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          deletedAt: json['deletedAt'] as Timestamp?,
          chartId: json['chartId']! as String,
          cardType: json['cardType'] as String,
          author: json['author'] as DocumentReference,
          userText: json['userText'] as String,
          linkPreviewData: json['linkPreviewData'] != null
              ? LinkPreviewData.fromJson(json['linkPreviewData'])
              : null,
          isDeleted: json['isDeleted'] as bool?,
          commentCounter: json['commentCount'] as int?,
          scrapCounter: json['scrapCounter'] as int?,
          likeCounter: json['likeCounter'] as int?,
          dislikeCounter: json['dislikeCounter'] as int?,
        );
  Map<String, dynamic?> toJson() {
    return {
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'chartId': chartId,
      'cardType': cardType,
      'author': author,
      'userText': userText,
      'linkPreviewData': linkPreviewData?.toJson(),
      'isDeleted': isDeleted,
      'commentCount': commentCounter,
      'scrapCounter': scrapCounter,
      'likeCounter': likeCounter,
      'dislikeCounter': dislikeCounter,
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
