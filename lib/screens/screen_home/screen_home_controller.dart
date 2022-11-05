import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class ScreenHomeController extends GetxController {
  var userInsightCardColRef =
      firestore.collection("userInsightCard").withConverter(
            fromFirestore: (snapshot, options) =>
                InsightCardModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  var _insightCards = Rx<List<QueryDocumentSnapshot<InsightCardModel>>>([]);

  List<QueryDocumentSnapshot<InsightCardModel>> get insightCards =>
      _insightCards.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userInsightCardColRef
        .orderBy("createdAt", descending: true)
        .limit(10)
        .get()
        .then(
      (value) {
        _insightCards.value = value.docs;
      },
    );
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
  }
}
