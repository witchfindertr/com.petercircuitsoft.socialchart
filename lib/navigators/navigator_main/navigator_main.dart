import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/navigators/navigator_explore.dart';
import 'package:socialchart/navigators/navigator_home.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/navigators/navigator_notice.dart';
import 'package:socialchart/navigators/navigator_profile.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:get/get.dart';
import 'package:socialchart/navigators/navigator_constant.dart';

class NavigatorMain extends GetView<MainNavigatorController> {
  const NavigatorMain({super.key});

  @override
  Widget build(BuildContext context) {
    // return CupertinoTabScaffold(
    //   tabBar: CupertinoTabBar(
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.home),
    //         label: "홈",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.search),
    //         label: "탐색",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.bell),
    //         label: "알림",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.person),
    //         label: "내정보",
    //       ),
    //     ],
    //   ),
    //   tabBuilder: (context, index) {
    //     return Obx(
    //       () => IndexedStack(
    //         index: controller.currentIndex.index,
    //         children: const [
    //           HomeNavigator(),
    //           ExploreNavigator(),
    //           NoticeNavigator(),
    //           ProfileNavigator(),
    //         ],
    //       ),
    //     );
    //   },
    // );
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.index,
          children: const [
            HomeNavigator(),
            ExploreNavigator(),
            NoticeNavigator(),
            ProfileNavigator(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
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
            onTap: (index) => controller.currentIndex = NavKeys.values[index],
          )),
    );
  }
}
