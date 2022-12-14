import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_list.dart';

class InsightCardAuthorController extends GetxController {
  InsightCardAuthorController({
    required this.cardId,
    required this.cardData,
  });

  final String cardId;
  final ModelInsightCard cardData;

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
              // if (refreshFunction != null) {
              //   refreshFunction!();
              // } else {
              //   print("paging controller is null");
              // }
              Get.snackbar("완료", "삭제되었습니다.");
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
