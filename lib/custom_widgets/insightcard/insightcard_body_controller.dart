import 'package:get/get.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

class InsightCardBodyController extends GetxController {
  InsightCardBodyController({required this.cardId, required this.cardData});

  final String cardId;
  final ModelInsightCard cardData;

  final _userText = Rxn<String>();
  String? get userText => _userText.value;
  set userText(String? value) => _userText.value = value;

  final _linkPreview = Rxn<LinkPreviewData>();
  LinkPreviewData? get linkPreview => _linkPreview.value;
  set linkPreview(LinkPreviewData? value) => _linkPreview.value = value;

  @override
  void onInit() {
    // TODO: implement onInit
    userText = cardData.userText;
    linkPreview = cardData.linkPreviewData;

    super.onInit();
  }
}
