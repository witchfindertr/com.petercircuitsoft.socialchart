import 'package:cloud_firestore/cloud_firestore.dart';

class ModelInsightCard {
  ModelInsightCard({
    required this.createdAt,
    this.deletedAt,
    this.lastModifiedAt,
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
    this.blockedUserId,
  });
  final Timestamp createdAt; //creation time
  final Timestamp? deletedAt; //creation time
  final Timestamp? lastModifiedAt; //creation time
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
  final List? blockedUserId;

  ModelInsightCard.fromJson(Map<String, dynamic?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          deletedAt: json['deletedAt'] as Timestamp?,
          lastModifiedAt: json['lastModifiedAt'] as Timestamp?,
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
          blockedUserId: json['blockedUserId'] as List?,
        );
  Map<String, dynamic?> toJson() {
    return {
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'lastModifiedAt': lastModifiedAt,
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
      'blockedUserId': blockedUserId,
    };
  }
}

//for the subcollection
class LinkPreviewData {
  LinkPreviewData({
    required this.url,
    this.image,
    this.size_x,
    this.size_y,
    this.title,
    this.description,
  });
  final String url;
  final String? image;
  int? size_x;
  int? size_y;
  final String? title;
  final String? description;

  set setX(int? value) => size_x = value;
  set setY(int? value) => size_y = value;
  LinkPreviewData.fromJson(Map<String, dynamic> json)
      : this(
          description: json['description'] as String?,
          image: json['image'] as String?,
          size_x: json['size_x'] as int?,
          size_y: json['size_y'] as int?,
          title: json['title'] as String?,
          url: json['url'] as String,
        );

  Map<String, dynamic> toJson() => {
        "url": url,
        "image": image,
        "size_x": size_x,
        "size_y": size_y,
        "title": title,
        "description": description,
      };
}
