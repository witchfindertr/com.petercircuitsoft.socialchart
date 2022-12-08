import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchart/models/model_chart_data.dart';
import 'package:socialchart/models/model_user_list.dart';
import 'package:socialchart/models/model_user_notice.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_report.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

const SHARD_COLLECTION_ID = "_counter_shards_";

CollectionReference<ModelUserData> userDataColRef() {
  return firestore.collection("userData").withConverter(
      fromFirestore: (snapshot, options) =>
          ModelUserData.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson());
}

CollectionReference<ModelInsightCard> userInsightCardColRef() {
  return firestore.collection("userInsightCard").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelInsightCard.fromJson(snapshot.data()!),
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

CollectionReference<ModelUserReport> userReportColRef() {
  return firestore.collection("userReports").withConverter(
      fromFirestore: (snapshot, options) =>
          ModelUserReport.fromJson(snapshot.data()!),
      toFirestore: ((value, options) => value.toJson()));
}

CollectionReference<ModelUserNotice> userNoticeColRef(String userId) {
  return firestore.collection("userData/$userId/userNotices").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelUserNotice.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<ModelUserList> likeUserListColRef(String cardId) {
  return firestore
      .collection("userInsightCard/$cardId/likeUserList")
      .withConverter(
          fromFirestore: ((snapshot, options) =>
              ModelUserList.fromJson(snapshot.data()!)),
          toFirestore: (value, options) => value.toJson());
}

CollectionReference<ModelUserList> scrapUserListColRef(String cardId) {
  return firestore
      .collection("userInsightCard/$cardId/scrapUserList")
      .withConverter(
          fromFirestore: ((snapshot, options) =>
              ModelUserList.fromJson(snapshot.data()!)),
          toFirestore: (value, options) => value.toJson());
}

//for Chart
CollectionReference<ModelChartData> chartDataColRef(String chartId) {
  return firestore.collection("chartData/$chartId").withConverter(
      fromFirestore: ((snapshot, options) =>
          ModelChartData.fromJson(snapshot.data()!)),
      toFirestore: (value, options) => value.toJson());
}
