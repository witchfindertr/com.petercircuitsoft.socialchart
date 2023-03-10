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

  final _hasNotice = true.obs;
  bool get hasNotice => _hasNotice.value;
  set hasNotice(bool value) => _hasNotice.value = value;

  void onBottomTabTap(int index) {
    if (index == NavKeys.notice.index) hasNotice = false;
    if (currentIndex.index != index) {
      currentIndex = NavKeys.values[index];
      return;
    }
    if (scrollControllerMap['$index${tabObservers[index].currentRouteName}']
            ?.offset ==
        null) {
      Get.back(id: index);
      return;
    }
    if (scrollControllerMap['$index${tabObservers[index].currentRouteName}']
            ?.offset !=
        0) {
      scrollControllerMap['$index${tabObservers[index].currentRouteName}']
          ?.animateTo(0,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Get.back(id: index);
    }
  }

  @override
  void onInit() {
    super.onInit();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      _isBottomTabVisible.value = !visible;
    });
    //todo get the notice counter and update hasNotice
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
