import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/navigators/tab_navigator_observer.dart';
import 'package:socialchart/utils/etc.dart';

class NavigatorMainController extends GetxController {
  static NavigatorMainController get to => Get.find();
  var _currentIndex = NavKeys.home.obs;
  var _isBottomTabVisible = true.obs;

  late StreamSubscription<bool> keyboardSubscription;
  var keyboardVisibilityController = KeyboardVisibilityController();

  NavKeys get currentIndex => _currentIndex.value;
  set currentIndex(NavKeys item) => _currentIndex.value = item;

  bool get isBottomTabVisible => _isBottomTabVisible.value;
  set isBottomTabVisible(bool visible) => _isBottomTabVisible.value = visible;

  List<TabNavigatorObserver> tabObservers = [
    TabNavigatorObserver(),
    TabNavigatorObserver(),
    TabNavigatorObserver(),
    TabNavigatorObserver(),
  ];

  Map<String, ScrollController> scrollControllerMap = {};

  @override
  void onInit() {
    // myScrollList.value[0].addEntries("":)
    // scrollToTop.value = () => {print("hello world")};
    // TODO: implement onInit
    super.onInit();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      _isBottomTabVisible.value = !visible;
    });
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
    keyboardSubscription.cancel();
  }
}
