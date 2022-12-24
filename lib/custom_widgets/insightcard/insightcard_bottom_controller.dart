import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/insightcard_data_fetcher.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_insightcard_list.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_list.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';

class InsightCardBottomController extends GetxController {
  InsightCardBottomController({
    required this.cardId,
    required this.cardData,
  });
  final ModelInsightCard cardData;
  final String cardId;

  // final _cardData = Rxn<ModelInsightCard>();
  // ModelInsightCard? get cardData => _cardData.value;
  // set cardData(ModelInsightCard? value) => _cardData.value = value;

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

  final _currentCommentCounter = 0.obs;
  int get currentCommentCounter => _currentCommentCounter.value;
  set currentCommentCounter(int value) => _currentCommentCounter.value = value;

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
          scrapUserListColRef(cardId).doc(currentUserId),
          ModelUserList(
            userId: currentUserId!,
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
        firebaseAuth;
        //add insightcard to scapped insightcard list
        transaction.set(
          scrappedInsightCardListColRef(currentUserId!).doc(cardId),
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
          scrapUserListColRef(cardId).doc(currentUserId!),
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
        transaction
            .delete(scrappedInsightCardListColRef(currentUserId!).doc(cardId));
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
              likeUserListColRef(cardId).doc(currentUserId),
              ModelUserList(
                  userId: currentUserId!, createdAt: Timestamp.now()));
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
          transaction.delete(likeUserListColRef(cardId).doc(currentUserId));
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

    currentLikeCounter = cardData.likeCounter ?? 0;
    currentScrapCounter = cardData.scrapCounter ?? 0;
    currentCommentCounter = cardData.commentCounter ?? 0;
    // ever(_cardData, (_) {
    //   currentLikeCounter = _?.likeCounter ?? 0;
    //   currentScrapCounter = _?.scrapCounter ?? 0;
    //   currentCommentCounter = _?.commentCounter ?? 0;
    // });
    // _cardData.value =
    //     Get.put(InsightCardDataFetcher(cardId: cardId), tag: cardId).data;
    // userDataColRef()
    //     .doc(userId)
    //     .get()
    //     .then((value) => userData.value = value.data());
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
