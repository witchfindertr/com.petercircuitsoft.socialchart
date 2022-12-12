import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_insightcard_list.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_list.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:intl/intl.dart';

class InsightCardController extends GetxController {
  InsightCardController({
    required this.userId,
    required this.cardId,
    required this.cardInfo,
    this.refreshFunction,
  });

  final VoidCallback? refreshFunction;
  final String userId;
  final String cardId;
  final ModelInsightCard cardInfo;

  var userData = Rxn<ModelUserData>();

  final _likePressed = false.obs;
  bool get likePressed => _likePressed.value;
  set likePressed(bool value) => _likePressed.value = value;

  final _scrapPressed = false.obs;
  bool get scrapPressed => _scrapPressed.value;
  set scrapPressed(bool value) => _scrapPressed.value = value;

  final _currentLikeCounter = 0.obs;
  int get currentLikeCounter => _currentLikeCounter.value;
  set currentLikeCounter(int value) => _currentLikeCounter.value = value;

  final _currentScrapCounter = 0.obs;
  int get currentScrapCounter => _currentScrapCounter.value;
  set currentScrapCounter(int value) => _currentScrapCounter.value = value;

  void onCommentButtonPress(NavKeys navKey) {
    //move to the Screen InsightCard with some argument or parameter
    Get.toNamed(ScreenInsightCard.routeName,
        arguments: cardId, id: navKey.index);
  }

  void onSharePress() async {
    try {
      var temp = await Share.share("Social chart", subject: cardId);
      print("done");
    } catch (e) {
      print(e);
    }
  }

  void onScrapButtonPress() {
    //server update
    //increase the number of Scrap count
    if (!scrapPressed) {
      scrapPressed = !scrapPressed;
      firestore.runTransaction((transaction) async {
        //add user to scrap user list
        transaction.set(
          scrapUserListColRef(cardId).doc(firebaseAuth.currentUser!.uid),
          ModelUserList(
            userId: firebaseAuth.currentUser!.uid,
            createdAt: Timestamp.now(),
          ),
        );
        //increase scrapCounter
        transaction.set(
          userInsightCardColRef()
              .doc(cardId)
              .collection(SHARD_COLLECTION_ID)
              .doc(),
          {
            "scrapCounter": 1,
          },
        );
        //add insightcard to scapped insightcard list
        transaction.set(
          scrappedInsightCardListColRef(userId).doc(cardId),
          ModelInsightCardList(
            cardId: cardId,
            createdAt: Timestamp.now(),
          ),
        );
      }).then((value) {
        currentScrapCounter++;
      }, onError: (e) => throw (e));
    } else {
      scrapPressed = !scrapPressed;
      firestore.runTransaction((transaction) async {
        transaction.delete(
          scrapUserListColRef(cardId).doc(firebaseAuth.currentUser!.uid),
        );
        transaction.set(
          userInsightCardColRef()
              .doc(cardId)
              .collection(SHARD_COLLECTION_ID)
              .doc(),
          {
            "scrapCounter": -1,
          },
        );
        //delete insightcard from scapped insightcard list
        transaction.delete(scrappedInsightCardListColRef(userId).doc(cardId));
      }).then(
        (value) {
          currentScrapCounter--;
        },
        onError: (e) => throw (e),
      );
    }
  }

  void onLikeButtonPress() {
    if (!likePressed) {
      likePressed = !likePressed;
      firestore.runTransaction(
        (transaction) async {
          transaction.set(
              likeUserListColRef(cardId).doc(firebaseAuth.currentUser!.uid),
              ModelUserList(
                  userId: firebaseAuth.currentUser!.uid,
                  createdAt: Timestamp.now()));
          transaction.set(
              userInsightCardColRef()
                  .doc(cardId)
                  .collection(SHARD_COLLECTION_ID)
                  .doc(),
              {"likeCounter": 1});
        },
      ).then((value) {
        print("added");
        currentLikeCounter++;
      }, onError: (e) => throw (e));
    } else {
      likePressed = !likePressed;
      firestore.runTransaction(
        (transaction) async {
          transaction.delete(
              likeUserListColRef(cardId).doc(firebaseAuth.currentUser!.uid));
          transaction.set(
              userInsightCardColRef()
                  .doc(cardId)
                  .collection(SHARD_COLLECTION_ID)
                  .doc(),
              {"likeCounter": -1});
        },
      ).then((value) {
        print("removed");
        currentLikeCounter--;
      }, onError: (e) => throw (e));
    }
  }

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

  void onDeletePress(BuildContext context) {
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
              if (refreshFunction != null) {
                refreshFunction!();
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

  @override
  void onInit() {
    // TODO: implement onInit
    print("refresh functions: ${refreshFunction != null}");
    super.onInit();
    currentLikeCounter = cardInfo.likeCounter ?? 0;
    currentScrapCounter = cardInfo.scrapCounter ?? 0;
    userDataColRef()
        .doc(userId)
        .get()
        .then((value) => userData.value = value.data());
    likeUserListColRef(cardId)
        .doc(firebaseAuth.currentUser?.uid)
        .get()
        .then((value) => likePressed = value.exists);
    scrapUserListColRef(cardId)
        .doc(firebaseAuth.currentUser?.uid)
        .get()
        .then((value) => scrapPressed = value.exists);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
