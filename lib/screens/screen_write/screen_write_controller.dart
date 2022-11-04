import 'package:any_link_preview/any_link_preview.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';

class ScreenWriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static final _userTagRegExp = RegExp(
    "(?!\\n)(?:^|\\s)([#]([$detectionContentLetters]+))|$urlRegexContent",
    multiLine: true,
  );
  static final _urlRegExp = RegExp(
    "(?!\\n)(?:^|\\s)$urlRegexContent",
    multiLine: true,
  );
  RegExp get userTagRegExp => _userTagRegExp;

  late AnimationController animationController;
  var key = GlobalKey<FormState>();
  var textController = TextEditingController();
  final _lastKey = Rx<String>("");
  final _userText = Rx<String>("");
  final _userLink = Rxn<String>();

  final linkData = Rxn<Metadata>();
  var linkImage = Rxn<String>();

  String get lastKey => _lastKey.value;
  set lastKey(String value) => _lastKey.value = value;

  String get userText => _userText.value;
  set userText(String value) => _userText.value = value;

  String? get userLink => _userLink.value;
  set userLink(String? value) => _userLink.value = value;

  void updateUserLink(String userText) {
    this.userText = userText;
    if (lastKey != "Enter" && lastKey != " ") return;
    var tempLink = extractDetections(userText, _urlRegExp).isEmpty
        ? ""
        : extractDetections(userText, _urlRegExp)[0];

    if (AnyLinkPreview.isValidLink(tempLink)) {
      userLink = tempLink;
    } else {
      userLink = null;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    ever(
      _userLink,
      (_) async {
        if (_ != null) {
          linkData.value = await AnyLinkPreview.getMetadata(link: _);
        }
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
}
