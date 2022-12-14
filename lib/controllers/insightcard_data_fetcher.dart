import 'package:get/get.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class InsightCardDataFetcher extends GetxController {
  InsightCardDataFetcher({required this.cardId});

  final String cardId;
  final _userInsightCardData = Rxn<ModelInsightCard>();
  ModelInsightCard? get data => _userInsightCardData.value;

  @override
  void refresh() {
    userInsightCardColRef().doc(cardId).get().then((value) {
      _userInsightCardData.value = value.data();
    });
    super.refresh();
  }

  @override
  void onInit() {
    userInsightCardColRef().doc(cardId).get().then((value) {
      _userInsightCardData.value = value.data();
    });
    super.onInit();
  }
}
