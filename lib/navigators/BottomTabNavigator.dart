import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'NavigationTree.dart';

class IndexController extends GetxController {
  static IndexController get to => Get.find();
  var currentIndex = TabItem.home.obs;

  void changeTabIndex(TabItem index) => currentIndex.value = index;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // ever(currentIndex, (_) => {if(currentIndex)});
  }
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
          currentIndex: bottomTabs[indexController.currentIndex.value]!.index,
          onTap: (index) =>
              indexController.changeTabIndex(TabItem.values[index]),
        ));
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(bottomTabs[tabItem]!.icon),
      label: bottomTabs[tabItem]!.name,
    );
  }
}
