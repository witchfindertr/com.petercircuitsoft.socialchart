import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:socialchart/navigators/tab_navigator_explore.dart';
import 'package:socialchart/navigators/tab_navigator_home.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/navigators/tab_navigator_notice.dart';
import 'package:socialchart/navigators/tab_navigator_observer.dart';
import 'package:socialchart/navigators/tab_navigator_profile.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_home/screen_home_controller.dart';

class NavigatorMain extends GetView<NavigatorMainController> {
  const NavigatorMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.index,
          children: [
            TabNavigatorHome(observer: controller.tabObservers[0]),
            TabNavigatorExplore(observer: controller.tabObservers[1]),
            TabNavigatorNotice(observer: controller.tabObservers[2]),
            TabNavigatorProfile(observer: controller.tabObservers[3]),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => controller.isBottomTabVisible
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "홈",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search),
                  label: "탐색",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.bell),
                  label: "알림",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                  label: "내정보",
                ),
              ],
              currentIndex: controller.currentIndex.index,
              onTap: (index) {
                if (controller.currentIndex.index == index) {
                  if (controller
                          .scrollControllerMap[
                              '$index${controller.tabObservers[index].currentRouteName}']
                          ?.offset !=
                      0) {
                    controller.scrollControllerMap[
                            '$index${controller.tabObservers[index].currentRouteName}']
                        ?.animateTo(0,
                            duration: Duration(seconds: 1), curve: Curves.ease);
                  } else {
                    Get.back(id: index);
                  }
                  // if (controller.scrollToTop != null) {
                  //   controller.scrollToTop!();
                  // } else {
                  //   Get.back(id: index);
                  // }
                }
                // Get.back(id: index);
                controller.currentIndex = NavKeys.values[index];
              },
            )
          : Container(height: 0)),
    );
  }
}
