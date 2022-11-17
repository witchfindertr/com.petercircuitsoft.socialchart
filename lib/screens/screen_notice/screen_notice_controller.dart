import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/mode_user_notice.dart';

class ScreenNoticeController extends GetxController {
  PagingController pagingController = PagingController<
      DocumentSnapshot<ModelUserNotice?>?,
      QueryDocumentSnapshot<ModelUserNotice>>(firstPageKey: null);
  final _pageSize = 20;

  ScrollController scrollController = ScrollController();
  // var _scrollOffset = 0.0.obs;
  // double get scrollOffset => _scrollOffset.value;

  final _userNotices = Rx<List<QueryDocumentSnapshot<ModelUserNotice>>>([]);

  List<QueryDocumentSnapshot<ModelUserNotice>> get userNotices =>
      _userNotices.value;

  void fetchUserNotice(DocumentSnapshot<Object?>? pageKey) async {
    QuerySnapshot<ModelUserNotice> loadedUserNotice;
    if (pageKey != null) {
      loadedUserNotice = await userNoticeColRef(firebaseAuth.currentUser!.uid)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedUserNotice = await userNoticeColRef(firebaseAuth.currentUser!.uid)
          .orderBy("createdAt", descending: true)
          .limit(_pageSize)
          .get();
    }
    final isLastPage = loadedUserNotice.docs.length < _pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(loadedUserNotice.docs);
    } else {
      final nextPageKey = loadedUserNotice.docs.last;
      pagingController.appendPage(loadedUserNotice.docs, nextPageKey);
    }
  }

  var isloading = true.obs;
  bool get isLoading => isloading.value;
  set isLoading(bool value) => isloading.value = value;

  @override
  void onInit() {
    // TODO: implement onInit
    // scrollController.addListener(() {
    //   _scrollOffset.value = scrollController.offset;
    // });
    pagingController.addPageRequestListener((pageKey) {
      fetchUserNotice(pageKey);
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
    pagingController.dispose();
    super.onClose();
  }
}
