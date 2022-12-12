import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';

class ScreenHomeController extends GetxController {
  var scrollController = ScrollController();

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
          .orderBy("isDeleted", descending: true)
          .where("isDeleted", isNotEqualTo: true)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedInsightCard = await userInsightCardColRef()
          .orderBy("isDeleted", descending: true)
          .where("isDeleted", isNotEqualTo: true)
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

  void refreshList() {
    pagingController.refresh();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    pagingController.addPageRequestListener((pageKey) {
      fetchInsightCard(pageKey);
    });
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
    scrollController.dispose();
    super.onClose();
  }
}
