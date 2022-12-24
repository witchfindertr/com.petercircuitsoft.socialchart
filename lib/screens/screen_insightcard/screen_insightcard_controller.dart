import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/insightcard_data_fetcher.dart';
import 'package:socialchart/controllers/user_data_fetcher.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_bottom_controller.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ScreenInsightCardController extends GetxController {
  ScreenInsightCardController({required this.cardId});
  final String cardId;

  // Controllers
  var textController = TextEditingController();
  var scrollController = AutoScrollController(
    //todo : need to figure out the height of the comment input widget height
    viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 70),
  );
  var autoScrollController = AutoScrollController();

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
          .where("isDeleted", isEqualTo: false)
          .orderBy("commentCreatedAt", descending: true)
          .orderBy("createdAt")
          .startAfterDocument(pageKey)
          .limit(_pageSize)
          .get();
    } else {
      loadedUserComment = await userCommentColRef(cardId)
          .where("isDeleted", isEqualTo: false)
          .orderBy("commentCreatedAt", descending: true)
          .orderBy("createdAt")
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

  final _cardAuthor = Rxn<ModelUserData>();
  ModelUserData? get cardAuthor => _cardAuthor.value;

  final _cardInfo = Rxn<ModelInsightCard>();
  ModelInsightCard? get cardInfo => _cardInfo.value;

  final _targetIndex = Rxn<int>();
  int? get targetIndex => _targetIndex.value;

  final _targetCommentAuthor = Rxn<String>();
  String? get targetCommentAuthor => _targetCommentAuthor.value;
  void setTargetComment({required int index, String? author}) {
    var userId = pagingController.itemList?[index].data().author;
    var user = Get.put(UserDataFetcher(userId: userId!), tag: userId);
    _targetIndex.value = index;
    _targetCommentAuthor.value = user.userData?.displayName;

    //scroll to index
    scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.end);
    print("clicked");
  }

  void clearTarget() {
    _targetIndex.value = null;
    _targetCommentAuthor.value = null;
  }

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

  //todo commentCounter function should be changed!
  void addComment() async {
    SocialChartController.to.showFullScreenLoadingIndicator = true;
    textFieldEnabled = false;
    focusNode.unfocus();
    var now = Timestamp.now();
    var commentCreatedAt =
        targetIndex != null && pagingController.itemList != null
            ? pagingController.itemList![targetIndex!].data().commentCreatedAt
            : now;
    await userCommentColRef(cardId)
        .add(ModelUserComment(
            author: currentUserId!,
            comment: textController.text,
            createdAt: now,
            commentCreatedAt: commentCreatedAt))
        .then((value) async {
      await userInsightCardColRef()
          .doc(cardId)
          .update({'commentCount': FieldValue.increment(1)});
      await refreshCardInfo();
      Get.find<InsightCardBottomController>(tag: cardId)
          .currentCommentCounter++;
      textController.clear();
      _targetIndex.value = null;
      Get.snackbar("성공", "댓글을 입력했습니다.");
    });

    textFieldEnabled = true;
    print("메세지 전송: ${textController.text}");
    SocialChartController.to.showFullScreenLoadingIndicator = false;
  }

  Future<void> refreshCardInfo() async {
    var result = await userInsightCardColRef().doc(cardId).get();
    _cardInfo.value = result.data();
    pagingController.refresh();
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
      _cardAuthor.value = userData.data();
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
