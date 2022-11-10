import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class ScreenHomeController extends GetxController {
  //todo....: is this okay? to.. put tag here??
  static ScreenHomeController get to => Get.find(tag: NavKeys.home.name);
  PagingController<DocumentSnapshot<Object?>?,
          QueryDocumentSnapshot<InsightCardModel>> pageController =
      PagingController(firstPageKey: null);

  var scrollController = ScrollController();
  final _pageSize = 10;

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
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedInsightCard = await userInsightCardColRef
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
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    pageController.addPageRequestListener((pageKey) {
      fetchInsightCard(pageKey);
    });
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
