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

class ModalScreenWriteModifyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ModalScreenWriteModifyController(
      {required this.chartId, this.cardId, this.cardData});

  static final _urlRegExp = RegExp(
    "(?!\\n)(?:^|\\s)$urlRegexContent" + "( |\n)",
    multiLine: true,
  );
  final String chartId;
  final String? cardId;

  final ModelInsightCard? cardData;
  var key = GlobalKey<FormState>();
  var textController = TextEditingController();

  final _userText = Rx<String>("");
  // final _previewLink = Rxn<String>();

  // final _linkData = Rxn<OgpData>();

  final _deletedLink = Rx<List<String>>([]);

  final _linkPreviewData = Rxn<LinkPreviewData>();
  LinkPreviewData? get linkPreviewData => _linkPreviewData.value;
  set linkPreviewData(LinkPreviewData? value) => _linkPreviewData.value = value;

  void setImageSize(int x, int y) {
    if (linkPreviewData != null) {
      linkPreviewData!.size_x = x;
      linkPreviewData!.size_y = y;
    }
  }

  String get userText => _userText.value;
  set userText(String value) => _userText.value = value;

  // String? get previewLink => _previewLink.value;
  // set previewLink(String? value) => _previewLink.value = value;

  // OgpData? get linkData => _linkData.value;
  // set linkData(OgpData? value) => _linkData.value = value;

  void deletedLink(String value) {
    //current rul added on the delete list
    _deletedLink.value.add(value);
    //delete current url
    linkPreviewData = null;
  }

  @override
  void onInit() {
    // modify post
    if (cardData != null) {
      _userText.value = cardData!.userText;
      textController.text = cardData!.userText;
      if (cardData!.linkPreviewData?.url != null) {
        linkPreviewData = cardData!.linkPreviewData;
        // OgpDataExtract.execute(cardData!.linkPreviewData!.url!).then(
        //   (value) {
        //     _linkData.value = value;
        //     previewLink = cardData!.linkPreviewData!.url!;
        //   },
        // );
      }
    }
    ever(
      _userText,
      (userText) async {
        Iterable<String> extractedLink =
            extractDetections(userText, _urlRegExp).isEmpty
                ? []
                : extractDetections(userText, _urlRegExp)
                    .where((element) => !_deletedLink.value.contains(element));
        //if there is no link just return
        if (extractedLink.isEmpty || linkPreviewData != null) return;
        OgpDataExtract.execute(extractedLink.first).then((value) {
          //update linkPreviewData
          linkPreviewData = LinkPreviewData(
            url: extractedLink.first,
            description: value?.description,
            image: value?.image,
            title: value?.title,
          );
          // _linkData.value = value;
          // previewLink = extractedLink.first;
        }, onError: (e) {
          print(e);
          deletedLink(extractedLink.first);
        });
      },
    );

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
          "lastModifiedAt": Timestamp.now(),
          "linkPreviewData": linkPreviewData != null
              ? {
                  "url": linkPreviewData!.url,
                  "description": linkPreviewData!.description,
                  "image": linkPreviewData!.image,
                  "title": linkPreviewData!.title,
                  "size_x": linkPreviewData!.size_x,
                  "size_y": linkPreviewData!.size_y,
                }
              : null,
        },
      );
      //for body update after modification
      var bodyContoller = Get.find<InsightCardBodyController>(tag: cardId);
      bodyContoller.linkPreview = linkPreviewData;
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
    var now = Timestamp.now();
    try {
      await userInsightCardColRef().add(
        ModelInsightCard(
          createdAt: now,
          lastModifiedAt: now,
          chartId: chartId,
          cardType: "sample",
          author: firestore
              .collection("userData")
              .doc(AuthController.to.firebaseUser.value?.uid),
          userText: userText,
          linkPreviewData: linkPreviewData,
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
