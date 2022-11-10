import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';

class ScreenInsightCardController extends GetxController {
  ScreenInsightCardController({required this.cardId});
  final String cardId;
  var InsightCardColRef = firestore.collection("userInsightCard").withConverter(
      fromFirestore: (snapshot, options) =>
          InsightCardModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson());

  var textController = TextEditingController();

  FocusNode focus = FocusNode();

  final _cardInfo = Rxn<InsightCardModel>();
  InsightCardModel? get cardInfo => _cardInfo.value;
  // set cardInfo(InsightCardModel? value) => _cardInfo.value = value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() async {
    _isLoading.value = true;
    // TODO: implement onInit
    super.onInit();
    //load the cardInfo
    var result = await InsightCardColRef.doc(cardId).get();
    _cardInfo.value = result.data();
    _isLoading.value = false;

    //textField on focus
    focus.addListener(_onFocusChange);
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

    focus.removeListener(_onFocusChange);
    focus.dispose();
  }

  void _onFocusChange() {
    MainNavigatorController.to.isBottomTabVisible = !focus.hasFocus;
  }
}
