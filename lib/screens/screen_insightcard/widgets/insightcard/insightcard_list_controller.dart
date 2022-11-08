import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class InsightCardListController extends GetxController {
  InsightCardListController({this.chartId, this.userId});
  PagingController<DocumentSnapshot<Object?>?,
          QueryDocumentSnapshot<InsightCardModel>> pageController =
      PagingController(firstPageKey: null);
  ScrollController scrollController = ScrollController();
  var _scrollOffset = 0.0.obs;
  final _pageSize = 10;
  double get scrollOffset => _scrollOffset.value;

  String? userId;
  String? chartId;

  var userInsightCardColRef =
      firestore.collection("userInsightCard").withConverter(
            fromFirestore: (snapshot, options) =>
                InsightCardModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  final _insightCards = Rx<List<QueryDocumentSnapshot<InsightCardModel>>>([]);

  List<QueryDocumentSnapshot<InsightCardModel>> get insightCards =>
      _insightCards.value;

  void fetchInsightCard(DocumentSnapshot<Object?>? pageKey) async {
    QuerySnapshot<InsightCardModel> loadedInsightCard;
    if (pageKey != null) {
      loadedInsightCard = await userInsightCardColRef
          .where("author", isEqualTo: userId)
          .where("chartId", isEqualTo: chartId)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedInsightCard = await userInsightCardColRef
          .where("author", isEqualTo: userId)
          .where("chartId", isEqualTo: chartId)
          .orderBy("createdAt", descending: true)
          .limit(_pageSize)
          .get();
    }
    final isLastPage = loadedInsightCard.docs.length < _pageSize;
    if (isLastPage) {
      pageController.appendLastPage(loadedInsightCard.docs);
    } else {
      final nextPageKey = loadedInsightCard.docs.last;
      pageController.appendPage(loadedInsightCard.docs, nextPageKey);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(() {
      _scrollOffset.value = scrollController.offset;
    });
    pageController.addPageRequestListener((pageKey) {
      fetchInsightCard(pageKey);
    });
  }
}
