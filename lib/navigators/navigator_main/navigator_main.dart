import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/navigators/tab_navigator_explore.dart';
import 'package:socialchart/navigators/tab_navigator_home.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/navigators/tab_navigator_notice.dart';
import 'package:socialchart/navigators/tab_navigator_profile.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:get/get.dart';

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
              items: [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house),
                  activeIcon: Icon(CupertinoIcons.house_fill),
                  label: "홈",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.rocket),
                  activeIcon: Icon(CupertinoIcons.rocket_fill),
                  label: "탐색",
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      const Icon(CupertinoIcons.bell),
                      Positioned(
                        // draw a red marble
                        top: 0.0,
                        right: 0.0,
                        child: controller.hasNotice
                            ? const Icon(Icons.brightness_1,
                                size: 8.0, color: Colors.redAccent)
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  activeIcon: Icon(CupertinoIcons.bell_fill),
                  label: "알림",
                ),
                const BottomNavigationBarItem(
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
          : const SizedBox(height: 0)),
    );
  }
}
