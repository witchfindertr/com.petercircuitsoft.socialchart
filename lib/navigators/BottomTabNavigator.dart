import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'BottomTabNavigatorInfo.dart';

class IndexController extends GetxController {
  static IndexController get to => Get.find();
  var currentIndex = TabItem.home.obs;

  void changeTabIndex(TabItem _index) => currentIndex.value = _index;
}

class BottomTabNavigator extends StatelessWidget {
  const BottomTabNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    IndexController indexController = Get.find();
    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            _buildItem(TabItem.home),
            _buildItem(TabItem.explore),
            _buildItem(TabItem.notice),
            _buildItem(TabItem.profile),
          ],
          currentIndex:
              tabNavigators[indexController.currentIndex.value]!.index,
          onTap: (index) =>
              indexController.changeTabIndex(TabItem.values[index]),
        ));
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(tabNavigators[tabItem]!.icon),
      label: tabNavigators[tabItem]!.name,
    );
  }
}
