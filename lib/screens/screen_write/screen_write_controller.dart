import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';

class ScreenWriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  var key = GlobalKey<FormState>();
  var textController = TextEditingController();
  final _userText = Rxn<String>();
  final _userLink = Rxn<String>();

  final linkData = Rxn<Metadata>();
  var linkImage = Rxn<String>();

  String? get userText => _userText.value;
  set userText(String? value) => _userText.value = value;

  String? get userLink => _userLink.value;
  set userLink(String? value) => _userLink.value = value;
  @override
  void onInit() {
    // TODO: implement onInit
    print("hello world");
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
