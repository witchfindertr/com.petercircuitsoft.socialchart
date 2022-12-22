import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_insightcard_list.dart';
import 'package:socialchart/models/model_user_list.dart';

class UserDB {
  UserDB({required this.currentUserId});
  final String currentUserId;

  static UserDB get instance =>
      UserDB(currentUserId: firebaseAuth.currentUser!.uid);

  Future<bool> checkAmIfollowing(String userId) {
    return followingListColRef(currentUserId).doc(userId).get().then((value) {
      if (value.exists)
        return true;
      else
        return false;
    }, onError: (e) {
      print(e);
      return false;
    });
  }

  Future<bool> following(String userId) {
    var now = Timestamp.now();
    return firestore.runTransaction(
      (transaction) async {
        //read following list
        var result = await transaction
            .get(followingListColRef(currentUserId).doc(userId));

        if (result.exists) throw ("the userId is already in the list.");

        //add user to the following list
        transaction.set(
          followingListColRef(currentUserId).doc(userId),
          ModelUserList(
            userId: userId,
            createdAt: now,
          ),
        );
        //increase my followingCounter
        transaction.set(
          userDataColRef()
              .doc(currentUserId)
              .collection(SHARD_COLLECTION_ID)
              .doc(),
          {
            "followingCounter": 1,
          },
        );
        //add me to the opponent follower list
        transaction.set(
          followerListColRef(userId).doc(currentUserId),
          ModelUserList(
            userId: currentUserId,
            createdAt: now,
          ),
        );
        //increase my followerCounter
        transaction.set(
          userDataColRef().doc(userId).collection(SHARD_COLLECTION_ID).doc(),
          {
            "followerCounter": 1,
          },
        );
      },
    ).then(
      (value) {
        return true;
      },
      onError: (e) {
        print(e);
        return false;
      },
    );
  }

  Future<bool> unFollowing(String userId) {
    var now = Timestamp.now();
    return firestore.runTransaction(
      (transaction) async {
        //read following list
        var result = await transaction
            .get(followingListColRef(currentUserId).doc(userId));

        if (!result.exists) throw ("There is no userId in the list");

        //add user to the following list
        transaction.delete(
          followingListColRef(currentUserId).doc(userId),
        );
        //increase my followingCounter
        transaction.set(
          userDataColRef()
              .doc(currentUserId)
              .collection(SHARD_COLLECTION_ID)
              .doc(),
          {
            "followingCounter": -1,
          },
        );
        //add me to the opponent follower list
        transaction.delete(
          followerListColRef(userId).doc(currentUserId),
        );
        //increase my followerCounter
        transaction.set(
          userDataColRef().doc(userId).collection(SHARD_COLLECTION_ID).doc(),
          {
            "followerCounter": -1,
          },
        );
      },
    ).then(
      (value) {
        return true;
      },
      onError: (e) {
        print(e);
        return false;
      },
    );
  }

  Future<bool> blockUser(String userId) {
    return firestore.runTransaction(
      (transaction) async {
        var result = await transaction
            .get(blockedUserListColRef(currentUserId).doc(userId));
        if (result.exists) {
          throw ("already in the list");
        }
        transaction.set(
          blockedUserListColRef(currentUserId).doc(userId),
          ModelUserList(
            userId: userId,
            createdAt: Timestamp.now(),
          ),
        );
      },
    ).then((value) => true, onError: (e) {
      print(e);
      return false;
    });
    // blockedUserListColRef(userId)
  }

  Future<bool> unBlockUser(String userId) {
    return firestore.runTransaction(
      (transaction) async {
        var result = await transaction
            .get(blockedUserListColRef(currentUserId).doc(userId));
        if (!result.exists) {
          throw ("there is no user in the list");
        }
        transaction.delete(
          blockedUserListColRef(currentUserId).doc(userId),
        );
      },
    ).then((value) => true, onError: (e) {
      print(e);
      return false;
    });
  }

  Future<bool> blockCard(String cardId) {
    return userInsightCardColRef().doc(cardId).update(
      {
        "blockedUserId": FieldValue.arrayUnion([currentUserId]),
      },
    ).then((value) => true, onError: (e) {
      print(e);
      return false;
    });
    // return firestore.runTransaction(
    //   (transaction) async {
    //     var result = await transaction
    //         .get(blockedCardListColRef(currentUserId).doc(cardId));
    //     if (result.exists) {
    //       throw ("there is no card in the list");
    //     }
    //     transaction.set(blockedCardListColRef(currentUserId).doc(cardId),
    //         ModelInsightCardList(cardId: cardId, createdAt: Timestamp.now()));
    //   },
    // ).then((value) => true, onError: (e) {
    //   print(e);
    //   return false;
    // });
  }
}
