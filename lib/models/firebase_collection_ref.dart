import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchart/models/model_chart_info.dart';
import 'package:socialchart/models/model_chart_list.dart';
import 'package:socialchart/models/model_data_set.dart';
import 'package:socialchart/models/model_insightcard_list.dart';
import 'package:socialchart/models/model_report_card.dart';
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

CollectionReference<ModelChartList> userInterestedChartListColRef(
    String userId) {
  return firestore
      .collection("userData/$userId/interestedChartList")
      .withConverter(
        fromFirestore: (snapshot, options) =>
            ModelChartList.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<ModelUserList> followerListColRef(String userId) {
  return firestore.collection("userData/$userId/followerList").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelUserList.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<ModelUserList> followingListColRef(String userId) {
  return firestore.collection("userData/$userId/followingList").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelUserList.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<ModelUserList> blockedUserListColRef(String userId) {
  return firestore.collection("userData/$userId/blockedUserList").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelUserList.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<ModelInsightCardList> blockedCardListColRef(String userId) {
  return firestore.collection("userData/$userId/blockedCardList").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelInsightCardList.fromJson(snapshot.data()!),
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
CollectionReference<ModelChartInfo> chartInfoColRef() {
  return firestore.collection("chartInfo").withConverter(
      fromFirestore: ((snapshot, options) =>
          ModelChartInfo.fromJson(snapshot.data()!)),
      toFirestore: (value, options) => value.toJson());
}

CollectionReference<ModelUserList> interestedChartUserListColRef(
    String chartId) {
  return firestore
      .collection("chartInfo/$chartId/interestedChartUserList")
      .withConverter(
        fromFirestore: ((snapshot, options) =>
            ModelUserList.fromJson(snapshot.data()!)),
        toFirestore: (value, options) => value.toJson(),
      );
}

//insight card report
CollectionReference<ModelReportCard> reportCardColRef() {
  return firestore.collection("cardReports").withConverter(
        fromFirestore: (snapshot, options) =>
            ModelReportCard.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

//for eventData
CollectionReference<ModelDataSet> dataSetRef() {
  return firestore.collection('dataSets').withConverter(
        fromFirestore: (snapshot, options) =>
            ModelDataSet.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}
