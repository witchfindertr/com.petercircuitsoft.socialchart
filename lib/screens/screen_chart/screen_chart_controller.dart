import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_chart_list.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_list.dart';

class ScreenChartController extends GetxController {
  ScreenChartController({required this.chartId});
  final String chartId;

  PagingController<DocumentSnapshot<ModelInsightCard?>?,
          QueryDocumentSnapshot<ModelInsightCard>> pagingController =
      PagingController(firstPageKey: null, invisibleItemsThreshold: 10);

  final _pageSize = 10;

  final _insightCards = Rx<List<QueryDocumentSnapshot<ModelInsightCard>>>([]);

  List<QueryDocumentSnapshot<ModelInsightCard>> get insightCards =>
      _insightCards.value;

  void fetchInsightCard(DocumentSnapshot<Object?>? pageKey) async {
    QuerySnapshot<ModelInsightCard> loadedInsightCard;
    if (pageKey != null) {
      loadedInsightCard = await userInsightCardColRef()
          .where("chartId", isEqualTo: chartId)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedInsightCard = await userInsightCardColRef()
          .where("chartId", isEqualTo: chartId)
          .orderBy("createdAt", descending: true)
          .limit(_pageSize)
          .get();
    }
    final isLastPage = loadedInsightCard.docs.length < _pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(loadedInsightCard.docs);
    } else {
      final nextPageKey = loadedInsightCard.docs.last;
      pagingController.appendPage(loadedInsightCard.docs, nextPageKey);
    }
  }

  ScrollController scrollController = ScrollController();

  var _isChartAdded = false.obs;

  bool get isChartAdded => _isChartAdded.value;
  set isChartAdded(bool value) => _isChartAdded.value = value;

  var _insightCardDate = Rx<Timestamp>(Timestamp.now());

  Timestamp get insightCardDate => _insightCardDate.value;
  set insightCardDate(Timestamp value) => _insightCardDate.value = value;

  void setDate(Timestamp date) {
    insightCardDate = date;
  }

  void toggleAddChart() {
    var timeStamp = Timestamp.now();
    firestore.runTransaction((transaction) async {
      if (isChartAdded) {
        //delete user to the list on chart collection
        transaction.delete(interestedChartUserListColRef(chartId)
            .doc(firebaseAuth.currentUser!.uid));
        //decrease interested user counter
        transaction.set(
            chartDataColRef()
                .doc(chartId)
                .collection(SHARD_COLLECTION_ID)
                .doc(),
            {"interestedUserCounter": -1});
        //delete chart id from the user interested chart list
        transaction.delete(
            userInterestedCharListColRef(firebaseAuth.currentUser!.uid)
                .doc(chartId));
      } else {
        //add user to the list on chart collection
        transaction.set(
            interestedChartUserListColRef(chartId)
                .doc(firebaseAuth.currentUser!.uid),
            ModelUserList(
                createdAt: timeStamp, userId: firebaseAuth.currentUser!.uid));
        //increase interested user counter
        transaction.set(
            chartDataColRef()
                .doc(chartId)
                .collection(SHARD_COLLECTION_ID)
                .doc(),
            {"interestedUserCounter": 1});
        //add chart id to the interested chart list
        transaction.set(
          userInterestedCharListColRef(firebaseAuth.currentUser!.uid)
              .doc(chartId),
          ModelChartList(
            chartId: chartId,
            createdAt: timeStamp,
          ),
        );
      }
    }).then((value) => isChartAdded = !isChartAdded);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    pagingController.addPageRequestListener((pageKey) {
      fetchInsightCard(pageKey);
    });
    interestedChartUserListColRef(chartId)
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) => isChartAdded = value.exists, onError: (e) => print(e));

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
