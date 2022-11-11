import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';

class ScreenInsightCardController extends GetxController {
  ScreenInsightCardController({required this.cardId});
  final String cardId;
  var InsightCardColRef = firestore.collection("userInsightCard").withConverter(
      fromFirestore: (snapshot, options) =>
          InsightCardModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson());

  // var UserCommentColRef =
  //     firestore.collection("userInsightCard/${_cardId.value}/comments").withConverter(
  //           fromFirestore: (snapshot, options) => {},
  //           toFirestore: (value, options) => {},
  //         );
  var textController = TextEditingController();
  var scrollController = ScrollController();

  final _cardId = "".obs;
  final _textFieldEnabled = true.obs;
  bool get textFieldEnabled => _textFieldEnabled.value;
  set textFieldEnabled(bool value) => _textFieldEnabled.value = value;

  final _cardInfo = Rxn<InsightCardModel>();
  InsightCardModel? get cardInfo => _cardInfo.value;
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
    var UserCommentColRef =
        firestore.collection("userInsightCard/$cardId/comments").withConverter(
              fromFirestore: (snapshot, options) =>
                  ModelUserComment.fromJson(snapshot.data()!),
              toFirestore: (value, options) => value.toJson(),
            );
    await UserCommentColRef.add(ModelUserComment(
            author: firebaseAuth.currentUser!.uid,
            comment: textController.text,
            createdAt: now,
            commentCreatedAt: targetComment?.commentCreatedAt ?? now))
        .then((value) async {
      await InsightCardColRef.doc(cardId)
          .update({'commentCount': FieldValue.increment(1)});
      await refreshCardInfo();
      Get.snackbar("성공", "댓글을 입력했습니다.");
    });

    textFieldEnabled = true;
    print("메세지 전송: ${textController.text}");
    SocialChartController.to.showFullScreenLoadingIndicator = false;
  }

  Future<void> refreshCardInfo() async {
    var result = await InsightCardColRef.doc(cardId).get();
    _cardInfo.value = result.data();
  }

  @override
  void onInit() async {
    _isLoading.value = true;
    // TODO: implement onInit

    super.onInit();
    _cardId.value = cardId;
    //load the cardInfo
    var result = await InsightCardColRef.doc(cardId).get();
    _cardInfo.value = result.data();
    _isLoading.value = false;

    // focusNode.addListener(_onFocusChangeCallback);
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

    // focusNode.removeListener(_onFocusChangeCallback);
  }
}
