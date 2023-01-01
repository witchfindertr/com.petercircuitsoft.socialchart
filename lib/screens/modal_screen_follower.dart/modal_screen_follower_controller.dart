import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_list.dart';

class ModalScreenFollowerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ModalScreenFollowerController({
    required this.userId,
  });
  final String userId;

  final List<Tab> follwerTabs = <Tab>[
    Tab(text: '팔로우'),
    Tab(text: '팔로워'),
  ];

  late TabController tabController;

  final int _pageSize = 10;

  PagingController<DocumentSnapshot<ModelUserList>?,
          QueryDocumentSnapshot<ModelUserList>> followerPagingController =
      PagingController(firstPageKey: null, invisibleItemsThreshold: 10);

  PagingController<DocumentSnapshot<ModelUserList>?,
          QueryDocumentSnapshot<ModelUserList>> followingPagingController =
      PagingController(firstPageKey: null, invisibleItemsThreshold: 10);

  final followerList = Rx<List<ModelUserList>>([]);
  final followingList = Rx<List<ModelUserList>>([]);

  void fetchFollowers(DocumentSnapshot<Object?>? pageKey) async {
    QuerySnapshot<ModelUserList> loadedFollowers;
    if (pageKey != null) {
      loadedFollowers = await followerListColRef(userId)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedFollowers = await followerListColRef(userId)
          .orderBy("createdAt", descending: true)
          .limit(_pageSize)
          .get();
    }
    final isLastPage = loadedFollowers.docs.length < _pageSize;
    if (isLastPage) {
      followerPagingController.appendLastPage(loadedFollowers.docs);
    } else {
      final nextPageKey = loadedFollowers.docs.last;
      followerPagingController.appendPage(loadedFollowers.docs, nextPageKey);
    }
  }

  void fetchFollowing(DocumentSnapshot<Object?>? pageKey) async {
    QuerySnapshot<ModelUserList> loadedFollowings;
    if (pageKey != null) {
      loadedFollowings = await followingListColRef(userId)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedFollowings = await followingListColRef(userId)
          .orderBy("createdAt", descending: true)
          .limit(_pageSize)
          .get();
    }
    final isLastPage = loadedFollowings.docs.length < _pageSize;
    if (isLastPage) {
      followingPagingController.appendLastPage(loadedFollowings.docs);
    } else {
      final nextPageKey = loadedFollowings.docs.last;
      followingPagingController.appendPage(loadedFollowings.docs, nextPageKey);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: follwerTabs.length);
    followerPagingController.addPageRequestListener((pageKey) {
      fetchFollowers(pageKey);
    });
    followingPagingController.addPageRequestListener((pageKey) {
      fetchFollowing(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
