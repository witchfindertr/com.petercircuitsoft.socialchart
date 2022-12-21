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
              // showSelectedLabels: false,
              // showUnselectedLabels: false,

              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house),
                  activeIcon: Icon(CupertinoIcons.house_fill),
                  label: "홈",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.news),
                  activeIcon: Icon(CupertinoIcons.news_solid),
                  label: "탐색",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.bell),
                  activeIcon: Icon(CupertinoIcons.bell_fill),
                  label: "알림",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                  activeIcon: Icon(CupertinoIcons.person_fill),
                  label: "내정보",
                ),
              ],
              currentIndex: controller.currentIndex.index,
              onTap: (index) {
                controller.onBottomTabTap(index);
              },
            )
          : SizedBox(height: 0)),
    );
  }
}
