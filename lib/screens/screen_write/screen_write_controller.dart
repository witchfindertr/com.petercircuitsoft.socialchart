import 'package:any_link_preview/any_link_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/controllers/isloading_controller.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';

import 'package:ogp_data_extract/ogp_data_extract.dart';

import 'package:http/http.dart' as http;

class ScreenWriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ScreenWriteController({required this.chartId});
  final insightCardCollectionRef =
      firestore.collection("userInsightCard").withConverter(
            fromFirestore: (snapshot, options) {
              // print("Snapshot: ${snapshot.data()}");
              return InsightCardModel.fromJson(snapshot.data()!);
            },
            toFirestore: (value, options) => value.toJson(),
          );

  static final _urlRegExp = RegExp(
    "(?!\\n)(?:^|\\s)$urlRegexContent" + "( |\n)",
    multiLine: true,
  );
  final String chartId;
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

  set deletedLink(String value) => _deletedLink.value.add(value);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(
      _userText,
      (userText) async {
        Iterable<String> extractedLink =
            extractDetections(userText, _urlRegExp).isEmpty
                ? []
                : extractDetections(userText, _urlRegExp)
                    .where((element) => !_deletedLink.value.contains(element));
        if (extractedLink.isEmpty) return;
        OgpDataExtract.execute(extractedLink.first).then((value) {
          if (value?.title != null && value?.description != null) {
            _linkData.value = value;
            previewLink = extractedLink.first;
          } else {
            //do nothing!
            deletedLink = extractedLink.first;
          }
        });
        // AnyLinkPreview.getMetadata(link: extractedLink.first).then((value) {
        //   if (value != null) {
        //     _linkData.value = value;
        //     previewLink = extractedLink.first;
        //   } else {
        //     //do nothing!
        //     deletedLink = extractedLink.first;
        //   }
        // });
      },
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //hide main navigation bar
    Get.find<MainNavigatorController>().isBottomTabVisible = false;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    //show the main navigation bar again
    Get.find<MainNavigatorController>().isBottomTabVisible = true;
  }

  Future<void> addInsightCard() async {
    IsLoadingController.to.isLoading = true;
    try {
      await insightCardCollectionRef.add(
        InsightCardModel(
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
      IsLoadingController.to.isLoading = false;
    } catch (e) {
      print(e.toString());
      IsLoadingController.to.isLoading = false;
      rethrow;
    }
  }
}
