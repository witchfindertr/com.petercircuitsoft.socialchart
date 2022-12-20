import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_list.dart';

class InsightCardAuthorController extends GetxController {
  InsightCardAuthorController({
    required this.cardId,
    required this.cardData,
    required this.cardTag,
  });

  final String cardId;
  final String cardTag;
  final ModelInsightCard cardData;

  final _amIfollowing = false.obs;
  bool get amIfollowing => _amIfollowing.value;
  set amIfollowing(bool value) => _amIfollowing.value = value;

  void onDislikeMenuPress() {
    firestore.runTransaction(
      (transaction) async {
        final dislikeUser = await transaction.get(
            dislikeUserListColRef(cardId).doc(firebaseAuth.currentUser!.uid));
        if (!dislikeUser.exists) {
          transaction.set(
            dislikeUser.reference,
            ModelUserList(
              userId: firebaseAuth.currentUser!.uid,
              createdAt: Timestamp.now(),
            ),
          );
          transaction.set(
            userInsightCardColRef()
                .doc(cardId)
                .collection(SHARD_COLLECTION_ID)
                .doc(),
            {"dislikeCounter": 1},
          );
          return "ADDED";
        } else {
          transaction.delete(
            dislikeUser.reference,
          );
          transaction.set(
            userInsightCardColRef()
                .doc(cardId)
                .collection(SHARD_COLLECTION_ID)
                .doc(),
            {"dislikeCounter": -1},
          );
          return "DELETED";
        }
      },
    ).then(
      (value) {
        switch (value) {
          case "ADDED":
            Get.snackbar("별로군요!", "의견을 반영하도록 할게요.");
            break;
          case "DELETED":
            Get.snackbar("취소", "별로라는 의견을 취소했어요.");
            break;
          default:
        }
      },
      onError: (e) {
        Get.snackbar("앗! 이런!", "알 수 없는 오류가 발생했어요.");
      },
    );
  }

  void onDeletePress(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("정말로 삭제하시겠습니까?"),
        content: Text("이 카드는 삭제되지만 다른 유저가 스크랩한 내용은 사라지지 않습니다."),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context); //close the dialog box
              if (Get.isSnackbarOpen) {
                Get.closeCurrentSnackbar();
              }
              userInsightCardColRef()
                  .doc(cardId)
                  .update({"isDeleted": true, "deletedAt": Timestamp.now()});
              var cardController =
                  Get.find<InsightCardController>(tag: cardTag);
              if (cardController != null) {
                cardController.refreshFunction!();
              } else {
                print("paging controller is null");
              }
              Get.snackbar("완료", "삭제되었습니다.");
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void toggleFollowButton(String userId) async {
    var result = amIfollowing
        ? await userDB.unFollowing(userId)
        : await userDB.following(userId);
    if (result) {
      amIfollowing = !amIfollowing;
      if (Get.isSnackbarOpen) {
        Get.back(closeOverlays: true);
      }
      Get.snackbar(
          duration: Duration(seconds: 1),
          "성공",
          "팔로우${amIfollowing ? " " : "를 취소"}했습니다.");
    } else {
      if (Get.isSnackbarOpen) {
        Get.back(closeOverlays: true);
      }
      Get.snackbar(duration: Duration(seconds: 1), "실패", "뭔가 문제가 있어요.");
    }
  }

  Future<bool> blockUser(String userId) async {
    return userDB.blockUser(userId);
  }

  @override
  void onInit() {
    userDB.checkAmIfollowing(cardData.author.id).then(
      (value) {
        amIfollowing = value;
      },
    );
    super.onInit();
  }
}
