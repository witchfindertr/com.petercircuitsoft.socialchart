import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_body.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_body_controller.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_insightcard.dart';

import 'package:ogp_data_extract/ogp_data_extract.dart';

import 'package:http/http.dart' as http;
import 'package:socialchart/socialchart/socialchart_controller.dart';

class ModalScreenModifyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ModalScreenModifyController(
      {required this.chartId, required this.cardId, this.cardData});

  static final _urlRegExp = RegExp(
    "(?!\\n)(?:^|\\s)$urlRegexContent" + "( |\n)",
    multiLine: true,
  );
  final String chartId;
  final String cardId;

  final ModelInsightCard? cardData;
  var key = GlobalKey<FormState>();
  var textController = TextEditingController();

  final _userText = Rx<String>("");
  final _previewLink = Rxn<String>();

  final _linkData = Rxn<OgpData>();

  final _deletedLink = Rx<List<String>>([]);

  String get userText => _userText.value;
  set userText(String value) => _userText.value = value;

  String? get previewLink => _previewLink.value;
  set previewLink(String? value) => _previewLink.value = value;

  OgpData? get linkData => _linkData.value;
  // set linkData(OgpData? value) => _linkData.value = value;

  void deletedLink(String value) {
    _deletedLink.value.add(value);
    _linkData.value = null;
  }

  @override
  void onInit() {
    // TODO: implement onInit

    ever(
      _userText,
      (userText) async {
        Iterable<String> extractedLink =
            extractDetections(userText, _urlRegExp).isEmpty
                ? []
                : extractDetections(userText, _urlRegExp)
                    .where((element) => !_deletedLink.value.contains(element));
        //if there is no link just return
        if (extractedLink.isEmpty) return;
        OgpDataExtract.execute(extractedLink.first).then((value) {
          _linkData.value = value;
          previewLink = extractedLink.first;
        }, onError: (e) {
          print(e);
          deletedLink(extractedLink.first);
        });
      },
    );
    if (cardData != null) {
      _userText.value = cardData!.userText;
      textController.text = cardData!.userText;
      if (cardData!.linkPreviewData?.url != null) {
        OgpDataExtract.execute(cardData!.linkPreviewData!.url!).then(
          (value) {
            _linkData.value = value;
            previewLink = cardData!.linkPreviewData!.url!;
          },
        );
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //hide main navigation bar
    // Get.find<NavigatorMainController>().isBottomTabVisible = false;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    //show the main navigation bar again
    // Get.find<NavigatorMainController>().isBottomTabVisible = true;
  }

  Future<void> updateInsightCard() async {
    var loading = SocialChartController.to;
    loading.showFullScreenLoadingIndicator = true;
    try {
      await userInsightCardColRef().doc(cardId).update(
        {
          "userText": userText,
          "linkPreviewData": _linkData.value != null
              ? {
                  "url": _linkData.value?.url,
                  "description": _linkData.value?.description,
                  "image": _linkData.value?.image,
                  "title": _linkData.value?.title,
                }
              : null,
        },
      );
      var bodyContoller = Get.find<InsightCardBodyController>(tag: cardId);
      bodyContoller.linkPreview = _linkData.value != null
          ? LinkPreviewData(
              url: _linkData.value?.url,
              description: _linkData.value?.description,
              image: _linkData.value?.image,
              title: _linkData.value?.title,
            )
          : null;
      bodyContoller.userText = userText;

      loading.showFullScreenLoadingIndicator = false;
    } catch (e) {
      print(e.toString());
      loading.showFullScreenLoadingIndicator = false;
      rethrow;
    }
  }

  Future<void> addInsightCard() async {
    var loading = SocialChartController.to;
    loading.showFullScreenLoadingIndicator = true;
    try {
      await userInsightCardColRef().add(
        ModelInsightCard(
          createdAt: Timestamp.now(),
          chartId: chartId,
          cardType: "sample",
          author: firestore
              .collection("userData")
              .doc(AuthController.to.firebaseUser.value?.uid),
          userText: userText,
          linkPreviewData: _linkData.value != null
              ? LinkPreviewData(
                  url: _linkData.value?.url,
                  description: _linkData.value?.description,
                  image: _linkData.value?.image,
                  title: _linkData.value?.title,
                )
              : null,
        ),
      );
      loading.showFullScreenLoadingIndicator = false;
    } catch (e) {
      print(e.toString());
      loading.showFullScreenLoadingIndicator = false;
      rethrow;
    }
  }
}
