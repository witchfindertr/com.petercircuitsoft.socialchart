import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_list.dart';

class ScreenProfileController extends GetxController {
  ScreenProfileController({required this.userId});
  final String userId;
  // static ScreenProfileController get to => Get.find();

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
          .where(
            "author",
            isEqualTo: firestore.doc("userData/${userId}"),
          )
          .orderBy("createdAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedInsightCard = await userInsightCardColRef()
          .where(
            "author",
            isEqualTo: firestore.doc("userData/${userId}"),
          )
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

  final _isCurrentUser = false.obs;

  var scrollController = ScrollController();

  bool get isCurrentUser => _isCurrentUser.value;
  set isCurrentUser(bool value) => _isCurrentUser.value = value;

  final Rxn<ModelUserData?> _userData = Rxn<ModelUserData?>();
  ModelUserData? get userData => _userData.value;
  set userData(ModelUserData? value) => _userData.value = value;

  final _amIfollowing = false.obs;
  bool get amIfollowing => _amIfollowing.value;
  set amIfollowing(bool value) => _amIfollowing.value = value;

  var isloading = true.obs;
  bool get isLoading => isloading.value;
  set isLoading(bool value) => isloading.value = value;

  Future<void> fetchProfileUserData() {
    try {
      return userDataColRef().doc(userId).get().then(
        (value) {
          userData = value.data();
        },
      );
    } catch (error) {
      rethrow;
    }
  }

  // Future<bool> checkAmIfollowing(String userId) {
  //   return followingListColRef(currentUserId)
  //       .doc(userId)
  //       .get()
  //       .then((value) {
  //     if (value.exists)
  //       return true;
  //     else
  //       return false;
  //   }, onError: (e) {
  //     print(e);
  //     return false;
  //   });
  // }

  void toggleFollowButton(String userId) async {
    var result = amIfollowing
        ? await userDB.unFollowing(userId)
        : await userDB.following(userId);
    if (result) {
      amIfollowing = !amIfollowing;
      Get.find<ScreenProfileController>(tag: currentUserId)
          .fetchProfileUserData();
      if (Get.isSnackbarOpen) {
        Get.back(closeOverlays: true);
      }
      Get.snackbar(
          duration: Duration(seconds: 1),
          "??????",
          "?????????${amIfollowing ? " " : "??? ??????"}????????????.");
    } else {
      if (Get.isSnackbarOpen) {
        Get.back(closeOverlays: true);
      }
      Get.snackbar(duration: Duration(seconds: 1), "??????", "?????? ????????? ?????????.");
    }
  }

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) {
      fetchInsightCard(pageKey);
    });
    isLoading = true;
    if (userId == firebaseAuth.currentUser?.uid) _isCurrentUser.value = true;
    await fetchProfileUserData();
    userDB.checkAmIfollowing(userId).then(
      (value) {
        amIfollowing = value;
      },
    );
    isLoading = false;

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    scrollController.dispose();
    super.onClose();
  }
}
