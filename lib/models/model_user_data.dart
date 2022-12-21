import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUserData {
  ModelUserData({
    required this.createdAt,
    required this.userEmail,
    this.backgroundImageUrl,
    this.profileImageUrl,
    this.displayName,
    this.introductionMessage,
    this.userUrl,
    this.belong,
    this.followerCounter = 0,
    this.followingCounter = 0,
  });
  final Timestamp createdAt; //creation time
  final String userEmail;
  final String? backgroundImageUrl; //user email
  final String? profileImageUrl;
  final String? displayName;
  final String? introductionMessage; // user text reported
  final String? userUrl;
  final String? belong;
  final int? followerCounter;
  final int? followingCounter;
  ModelUserData.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          userEmail: json['userEmail']! as String,
          backgroundImageUrl: json['backgroundImageUrl'] as String?,
          profileImageUrl: json['profileImageUrl'] as String?,
          displayName: json['displayName'] as String?,
          introductionMessage: json['introductionMessage'] as String?,
          userUrl: json['userUrl'] as String?,
          belong: json['belong'] as String?,
          followerCounter: json['followerCounter'] as int?,
          followingCounter: json['followingCounter'] as int?,
        );
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'userEmail': userEmail,
      'backgroundImageUrl': backgroundImageUrl,
      'profileImageUrl': profileImageUrl,
      'displayName': displayName,
      'introductionMessage': introductionMessage,
      'userUrl': userUrl,
      'belong': belong,
      'followerCounter': followerCounter,
      'followingCounter': followingCounter,
    };
  }
}
