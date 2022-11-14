import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchart/models/mode_user_notice.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_report.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference<UserDataModel> userDataColRef() {
  return firestore.collection("userData").withConverter(
      fromFirestore: (snapshot, options) =>
          UserDataModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson());
}

CollectionReference<InsightCardModel> userInsightCardColRef() {
  return firestore.collection("userInsightCard").withConverter(
        fromFirestore: (snapshot, options) =>
            InsightCardModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<ModelUserComment> userCommentColRef(String cardId) {
  return firestore.collection("userInsightCard/$cardId/comments").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelUserComment.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<UserReportModel> userReportColRef() {
  return firestore.collection("userReports").withConverter(
      fromFirestore: (snapshot, options) =>
          UserReportModel.fromJson(snapshot.data()!),
      toFirestore: ((value, options) => value.toJson()));
}

CollectionReference<ModelUserNotice> userNoticeColRef(String userId) {
  return firestore.collection("userData/$userId/userNotices").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelUserNotice.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}