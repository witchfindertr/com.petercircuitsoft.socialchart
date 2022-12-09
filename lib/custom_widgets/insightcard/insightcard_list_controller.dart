import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class InsightCardListController extends GetxController {
  InsightCardListController({this.chartId, this.userId});

  PagingController<DocumentSnapshot<ModelInsightCard?>?,
          QueryDocumentSnapshot<ModelInsightCard>> pagingController =
      PagingController(firstPageKey: null, invisibleItemsThreshold: 10);

  final _pageSize = 10;
  late StreamController<ScrollNotification> streamController;

  late Set<ItemContext> itemsContexts;
  var _scrollOffset = 0.0.obs;
  double get scrollOffset => _scrollOffset.value;

  String? userId;
  String? chartId;

  final _insightCards = Rx<List<QueryDocumentSnapshot<ModelInsightCard>>>([]);

  List<QueryDocumentSnapshot<ModelInsightCard>> get insightCards =>
      _insightCards.value;

  void fetchInsightCard(DocumentSnapshot<Object?>? pageKey) async {
    QuerySnapshot<ModelInsightCard> loadedInsightCard;
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
    itemsContexts = Set<ItemContext>();
    streamController = StreamController<ScrollNotification>();
    streamController.onListen = () => print("onListen");
    streamController.stream.listen((event) => _onScroll);
  }

  void _onScroll(List<ScrollNotification> notifications) {
    itemsContexts.forEach((ItemContext item) {
      // Retrieve the RenderObject, linked to a specific item
      final RenderObject? object = item.context.findRenderObject();

      // If none was to be found, or if not attached, leave by now
      // As we are dealing with Slivers, items no longer part of the
      // viewport will be detached
      if (object == null || !object.attached) {
        return;
      }

      // Retrieve the viewport related to the scroll area
      final RenderAbstractViewport viewport =
          RenderAbstractViewport.of(object)!;
      final double vpHeight = viewport.paintBounds.height;
      final ScrollableState scrollableState = Scrollable.of(item.context)!;
      final ScrollPosition scrollPosition = scrollableState.position;
      final RevealedOffset vpOffset = viewport.getOffsetToReveal(object, 0.0);

      // Retrieve the dimensions of the item
      final Size size = object.semanticBounds.size;

      // Check if the item is in the viewport
      final double deltaTop = vpOffset.offset - scrollPosition.pixels;
      final double deltaBottom = deltaTop + size.height;

      bool isInViewport = false;

      isInViewport = (deltaTop >= 0.0 && deltaTop < vpHeight);
      if (!isInViewport) {
        isInViewport = (deltaBottom > 0.0 && deltaBottom < vpHeight);
      }

      print(
          '${item.id} --> offset: ${vpOffset.offset} -- VP?: ${isInViewport}');
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pagingController.dispose();
  }
}

class ItemContext {
  final BuildContext context;
  final int id;

  ItemContext({required this.context, required this.id});

  @override
  bool operator ==(Object other) => other is ItemContext && other.id == id;
}
