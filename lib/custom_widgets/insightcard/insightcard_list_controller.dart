import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';

class InsightCardListController extends GetxController {
  InsightCardListController({this.chartId, this.userId});

  PagingController<DocumentSnapshot<InsightCardModel?>?,
          QueryDocumentSnapshot<InsightCardModel>> pagingController =
      PagingController(firstPageKey: null, invisibleItemsThreshold: 10);

  final _pageSize = 10;

  var _scrollOffset = 0.0.obs;
  double get scrollOffset => _scrollOffset.value;

  String? userId;
  String? chartId;

  final _insightCards = Rx<List<QueryDocumentSnapshot<InsightCardModel>>>([]);

  List<QueryDocumentSnapshot<InsightCardModel>> get insightCards =>
      _insightCards.value;

  void fetchInsightCard(DocumentSnapshot<Object?>? pageKey) async {
    QuerySnapshot<InsightCardModel> loadedInsightCard;
    if (pageKey != null) {
      loadedInsightCard = await userInsightCardColRef()
          .where("author",
              isEqualTo:
                  userId != null ? firestore.doc("userData/${userId}") : null)
          .where("chartId", isEqualTo: chartId)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedInsightCard = await userInsightCardColRef()
          .where("author",
              isEqualTo:
                  userId != null ? firestore.doc("userData/${userId}") : null)
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      fetchInsightCard(pageKey);
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pagingController.dispose();
  }
}
