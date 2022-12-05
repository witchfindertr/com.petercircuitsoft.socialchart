import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  UserDataModel({
    required this.createdAt,
    required this.userEmail,
    this.backgroundImageUrl,
    this.imageUrl,
    this.displayName,
    this.introductionMessage,
    this.userUrl,
    this.belong,
    this.followerCount = 0,
    this.followingCount = 0,
  });
  final Timestamp createdAt; //creation time
  final String userEmail;
  final String? backgroundImageUrl; //user email
  final String? imageUrl;
  final String? displayName;
  final String? introductionMessage; // user text reported
  final String? userUrl;
  final String? belong;
  final int? followerCount;
  final int? followingCount;
  UserDataModel.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          userEmail: json['userEmail']! as String,
          backgroundImageUrl: json['backgroundImageUrl'] as String?,
          imageUrl: json['imageUrl'] as String?,
          displayName: json['displayName'] as String?,
          introductionMessage: json['introductionMessage'] as String?,
          userUrl: json['userUrl'] as String?,
          belong: json['belong'] as String?,
          followerCount: json['followerCount'] as int?,
          followingCount: json['followingCount'] as int?,
        );
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'userEmail': userEmail,
      'backgroundImageUrl': backgroundImageUrl,
      'imageUrl': imageUrl,
      'displayName': displayName,
      'introductionMessage': introductionMessage,
      'userUrl': userUrl,
      'belong': belong,
      'followerCount': followerCount,
      'followingCount': followingCount,
    };
  }
}
