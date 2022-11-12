import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_report.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_controller.dart';

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
  return FirebaseFirestore.instance.collection("userReports").withConverter(
      fromFirestore: (snapshot, options) =>
          UserReportModel.fromJson(snapshot.data()!),
      toFirestore: ((value, options) => value.toJson()));
}
