import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_list.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';

class InsightCardController extends GetxController {
  InsightCardController(
      {required this.userId, required this.cardId, required this.cardInfo});

  final String userId;
  final String cardId;
  final InsightCardModel cardInfo;

  var userData = Rxn<UserDataModel>();

  var _likePressed = false.obs;
  var _scrapPressed = false.obs;

  bool get likePressed => _likePressed.value;
  set likePressed(bool value) => _likePressed.value = value;
  bool get scrapPressed => _scrapPressed.value;
  set scrapPressed(bool value) => _scrapPressed.value = value;

  var _currentLikeCounter = 0.obs;
  var _currentScrapCounter = 0.obs;

  int get currentLikeCounter => _currentLikeCounter.value;
  set currentLikeCounter(int value) => _currentLikeCounter.value = value;
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
    print("Scrap button pressed, $cardId");
    if (!scrapPressed) {
      scrapPressed = !scrapPressed;
      firestore.runTransaction((transaction) async {
        transaction.set(
            scrapUserListColRef(cardId).doc(firebaseAuth.currentUser!.uid),
            ModelUserList(
                userId: firebaseAuth.currentUser!.uid,
                createdAt: Timestamp.now()));

        transaction.set(
            userInsightCardColRef()
                .doc(cardId)
                .collection(SHARD_COLLECTION_ID)
                .doc(),
            {"scrapCounter": 1});
      }).then((value) {
        currentScrapCounter++;
      }, onError: (e) => throw (e));
    } else {
      scrapPressed = !scrapPressed;
      firestore.runTransaction((transaction) async {
        transaction.delete(
            scrapUserListColRef(cardId).doc(firebaseAuth.currentUser!.uid));

        transaction.set(
            userInsightCardColRef()
                .doc(cardId)
                .collection(SHARD_COLLECTION_ID)
                .doc(),
            {"scrapCounter": -1});
      }).then((value) {
        currentScrapCounter--;
      }, onError: (e) => throw (e));
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

  @override
  void onInit() {
    // TODO: implement onInit
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