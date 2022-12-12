import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchart/models/model_chart_data.dart';
import 'package:socialchart/models/model_chart_list.dart';
import 'package:socialchart/models/model_insightcard_list.dart';
import 'package:socialchart/models/model_user_list.dart';
import 'package:socialchart/models/model_user_notice.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_report.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

const SHARD_COLLECTION_ID = "_counter_shards_";

//for user
CollectionReference<ModelUserData> userDataColRef() {
  return firestore.collection("userData").withConverter(
      fromFirestore: (snapshot, options) =>
          ModelUserData.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson());
}

CollectionReference<ModelUserNotice> userNoticeColRef(String userId) {
  return firestore.collection("userData/$userId/userNotices").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelUserNotice.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<ModelInsightCardList> scrappedInsightCardListColRef(
    String userId) {
  return firestore
      .collection("userData/$userId/scrappedInsightCardList")
      .withConverter(
        fromFirestore: (snapshot, options) =>
            ModelInsightCardList.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<ModelChartList> userInterestedCharListColRef(
    String userId) {
  return firestore
      .collection("userData/$userId/interestedChartList")
      .withConverter(
        fromFirestore: (snapshot, options) =>
            ModelChartList.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

//for insightcard
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

CollectionReference<ModelUserList> dislikeUserListColRef(String cardId) {
  return firestore
      .collection("userInsightCard/$cardId/dislikeUserList")
      .withConverter(
          fromFirestore: ((snapshot, options) =>
              ModelUserList.fromJson(snapshot.data()!)),
          toFirestore: (value, options) => value.toJson());
}

//for report
CollectionReference<ModelUserReport> userReportColRef() {
  return firestore.collection("userReports").withConverter(
      fromFirestore: (snapshot, options) =>
          ModelUserReport.fromJson(snapshot.data()!),
      toFirestore: ((value, options) => value.toJson()));
}

//for Chart
CollectionReference<ModelChartData> chartDataColRef() {
  return firestore.collection("chartData").withConverter(
      fromFirestore: ((snapshot, options) =>
          ModelChartData.fromJson(snapshot.data()!)),
      toFirestore: (value, options) => value.toJson());
}

CollectionReference<ModelUserList> interestedChartUserListColRef(
    String chartId) {
  return firestore
      .collection("chartData/$chartId/interestedChartUserList")
      .withConverter(
          fromFirestore: ((snapshot, options) =>
              ModelUserList.fromJson(snapshot.data()!)),
          toFirestore: (value, options) => value.toJson());
}
