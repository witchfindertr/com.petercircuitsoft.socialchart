import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';

class ScreenInsightCardController extends GetxController {
  ScreenInsightCardController({required this.cardId});
  final String cardId;

  // Controllers
  var textController = TextEditingController();
  var scrollController = ScrollController();

  PagingController<DocumentSnapshot<ModelUserComment?>?,
          QueryDocumentSnapshot<ModelUserComment>> pagingController =
      PagingController(firstPageKey: null);

  //for scroll controll
  final _scrollOffset = 0.0.obs;
  final _pageSize = 10;
  double get scrollOffset => _scrollOffset.value;

  final _userComments = Rx<List<QueryDocumentSnapshot<ModelUserComment>>>([]);

  List<QueryDocumentSnapshot<ModelUserComment>> get userComments =>
      _userComments.value;

  void fetchUserComment(DocumentSnapshot<ModelUserComment?>? pageKey) async {
    QuerySnapshot<ModelUserComment> loadedUserComment;
    if (pageKey != null) {
      loadedUserComment = await userCommentColRef(cardId)
          .orderBy("createdAt", descending: true)
          .orderBy("commentCreatedAt", descending: true)
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedUserComment = await userCommentColRef(cardId)
          .orderBy("createdAt", descending: true)
          .orderBy("commentCreatedAt", descending: true)
          .limit(_pageSize)
          .get();
    }
    final isLastPage = loadedUserComment.docs.length < _pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(loadedUserComment.docs);
    } else {
      final nextPageKey = loadedUserComment.docs.last;
      pagingController.appendPage(loadedUserComment.docs, nextPageKey);
    }
  }

  final _cardId = "".obs;

  final _textFieldEnabled = true.obs;

  bool get textFieldEnabled => _textFieldEnabled.value;
  set textFieldEnabled(bool value) => _textFieldEnabled.value = value;

  final _isCurrentUser = false.obs;
  bool get isCurrentUser => _isCurrentUser.value;

  final _authorData = Rxn<ModelUserData>();
  ModelUserData? get authorData => _authorData.value;

  final _cardInfo = Rxn<ModelInsightCard>();
  ModelInsightCard? get cardInfo => _cardInfo.value;
  // set cardInfo(InsightCardModel? value) => _cardInfo.value = value;

  final _targetComment = Rxn<ModelUserComment>();
  ModelUserComment? get targetComment => _targetComment.value;
  set targetComment(ModelUserComment? value) => _targetComment.value = value;

  FocusNode focusNode = FocusNode();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void scrollToEnd() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      ),
    );
  }

  void addReply() async {
    SocialChartController.to.showFullScreenLoadingIndicator = true;
    textFieldEnabled = false;
    focusNode.unfocus();
    var now = Timestamp.now();
    await userCommentColRef(cardId)
        .add(ModelUserComment(
            author: firebaseAuth.currentUser!.uid,
            comment: textController.text,
            createdAt: now,
            commentCreatedAt: targetComment?.commentCreatedAt ?? now))
        .then((value) async {
      await userInsightCardColRef()
          .doc(cardId)
          .update({'commentCount': FieldValue.increment(1)});
      await refreshCardInfo();
      Get.snackbar("성공", "댓글을 입력했습니다.");
    });

    textFieldEnabled = true;
    print("메세지 전송: ${textController.text}");
    SocialChartController.to.showFullScreenLoadingIndicator = false;
  }

  Future<void> refreshCardInfo() async {
    var result = await userInsightCardColRef().doc(cardId).get();
    _cardInfo.value = result.data();
  }

  @override
  void onInit() async {
    _isLoading.value = true;
    // TODO: implement onInit
    pagingController.addPageRequestListener((pageKey) {
      fetchUserComment(pageKey);
    });

    scrollController.addListener(() {
      _scrollOffset.value = scrollController.offset;
    });

    _cardId.value = cardId;
    //load the cardInfo
    var result = await userInsightCardColRef().doc(cardId).get();
    _cardInfo.value = result.data();

    _isCurrentUser.value = cardInfo?.author.id == firebaseAuth.currentUser?.uid;
    if (!isCurrentUser) {
      var userData = await userDataColRef().doc(cardInfo?.author.id).get();
      _authorData.value = userData.data();
    }

    super.onInit();

    _isLoading.value = false;
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
    textController.dispose();
    scrollController.dispose();
    pagingController.dispose();
  }
}
