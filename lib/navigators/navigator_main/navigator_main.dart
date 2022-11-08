import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/navigators/tab_navigator_explore.dart';
import 'package:socialchart/navigators/tab_navigator_home.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/navigators/tab_navigator_notice.dart';
import 'package:socialchart/navigators/tab_navigator_profile.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_home/screen_home_controller.dart';

class NavigatorMain extends GetView<MainNavigatorController> {
  const NavigatorMain({super.key});

  @override
  Widget build(BuildContext context) {
    final psController2 =
        Get.context!.findAncestorWidgetOfExactType<PrimaryScrollController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.index,
          children: const [
            TabNavigatorHome(),
            TabNavigatorExplore(),
            TabNavigatorNotice(),
            TabNavigatorProfile(),
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
                final psController1 = PrimaryScrollController.of(Get.context!);

                print(psController1.toString());
                print(psController2.toString());
                if (controller.currentIndex.index == index) {
                  switch (index) {
                    case 0: //Home
                      ScreenHomeController.to.scrollController.animateTo(0,
                          duration: Duration(seconds: 1), curve: Curves.ease);
                      break;
                    case 1:
                      break;
                    case 2:
                      break;
                    case 3:
                      break;
                    default:
                      break;
                  }
                  ;
                }
                controller.currentIndex = NavKeys.values[index];
              },
            )
          : Container(height: 0)),
    );
  }
}
