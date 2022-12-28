import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_chart_list.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_list.dart';

import 'package:stream_transform/stream_transform.dart';

class ScreenChartController extends GetxController {
  ScreenChartController({required this.chartId});
  final String chartId;

  //for pagination
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
          .orderBy("isDeleted", descending: true)
          .where("isDeleted", isNotEqualTo: true)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedInsightCard = await userInsightCardColRef()
          .where("chartId", isEqualTo: chartId)
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
    //update initial currentInsightCardData
    if (pageKey == pagingController.firstPageKey) {
      _currentInsightCardData.value = pagingController.itemList?[0].data();
    }
  }

  ScrollController scrollController = ScrollController();

  final _isChartAdded = false.obs;

  bool get isChartAdded => _isChartAdded.value;
  set isChartAdded(bool value) => _isChartAdded.value = value;

  final _insightCardDate = Rx<Timestamp>(Timestamp.now());

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
        transaction
            .delete(interestedChartUserListColRef(chartId).doc(currentUserId));
        //decrease interested user counter
        transaction.set(
          chartInfoColRef().doc(chartId).collection(SHARD_COLLECTION_ID).doc(),
          {"interestedUserCounter": -1},
        );
        //delete chart id from the user interested chart list
        transaction.delete(userInterestedChartListColRef(currentUserId!).doc());
      } else {
        //add user to the list on chart collection
        transaction.set(
            interestedChartUserListColRef(chartId).doc(currentUserId),
            ModelUserList(createdAt: timeStamp, userId: currentUserId!));
        //increase interested user counter
        transaction.set(
          chartInfoColRef().doc(chartId).collection(SHARD_COLLECTION_ID).doc(),
          {"interestedUserCounter": 1},
        );
        //add chart id to the interested chart list
        transaction.set(
          userInterestedChartListColRef(currentUserId!).doc(),
          ModelChartList(
            chartId: chartId,
            createdAt: timeStamp,
          ),
        );
      }
    }).then(
      (value) => isChartAdded = !isChartAdded,
    );
  }

  //for chart cursor
  StreamController<ScrollNotification> streamController =
      StreamController<ScrollNotification>();
  final _contextItems = Rx<List<ContextItem>>([]);

  final _currentItemIndex = 0.obs;
  int get currentItemIndex => _currentItemIndex.value;
  set currentItemIndex(int value) => _currentItemIndex.value = value;

  final _currentInsightCardData = Rxn<ModelInsightCard>();
  ModelInsightCard? get currentInsightCardData => _currentInsightCardData.value;
  set currentInsightCardData(ModelInsightCard? value) =>
      _currentInsightCardData.value = value;

  void _onScroll(ScrollNotification notification) {
    for (var contextItem in _contextItems.value) {
      final RenderObject? object = contextItem.context.findRenderObject();
      if (object == null || !object.attached) {
        return;
      }
      final RenderAbstractViewport viewport =
          RenderAbstractViewport.of(object)!;
      final double vpHeight = notification.metrics.viewportDimension;
      final RevealedOffset vpOffset = viewport.getOffsetToReveal(object, 0.0);

      final Size size = object.semanticBounds.size;
      final double deltaTop = vpOffset.offset - notification.metrics.pixels;

      final double deltaBottom = deltaTop + size.height;

      if (deltaTop < (0.15 * vpHeight) && deltaBottom > (0.15 * vpHeight)) {
        // print(contextItem.index);
        _currentInsightCardData.value =
            pagingController.itemList?[contextItem.index].data();
      }
    }
    contextItemLength = _contextItems.value.length;
  }

  void addContextItem(ContextItem contextItem) {
    _contextItems.value
        .removeWhere((element) => element.index == contextItem.index);
    _contextItems.value.add(contextItem);
  }

  void removeContextItem(int index) {
    _contextItems.value.removeWhere((element) => element.index == index);
  }

  final _contextItemLength = 0.obs;
  int get contextItemLength => _contextItemLength.value;
  set contextItemLength(int value) => _contextItemLength.value = value;

  @override
  void onInit() {
    super.onInit();
    print("screen chart controller on init");
    pagingController.addPageRequestListener((pageKey) {
      fetchInsightCard(pageKey);
    });

    streamController.stream
        .audit(const Duration(milliseconds: 200))
        .listen(_onScroll);

    interestedChartUserListColRef(chartId)
        .doc(currentUserId)
        .get()
        .then((value) => isChartAdded = value.exists, onError: (e) => print(e));
  }

  @override
  void onClose() {
    streamController.close();
    pagingController.dispose();
    super.onClose();
  }
}

class ContextItem {
  final BuildContext context;
  final int index;

  ContextItem({required this.context, required this.index});
}
