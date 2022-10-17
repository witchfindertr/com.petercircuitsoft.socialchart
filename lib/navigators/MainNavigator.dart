import 'package:flutter/material.dart';
import 'BottomTabNavigator.dart';

import 'NavigationTree.dart';

import 'package:get/get.dart';

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    IndexController indexController = Get.put(IndexController());
    return Scaffold(
      body: Stack(
        children: [
          _buildOffstageNavigator(TabItem.home),
          _buildOffstageNavigator(TabItem.explore),
          _buildOffstageNavigator(TabItem.notice),
          _buildOffstageNavigator(TabItem.profile),
        ],
      ),
      bottomNavigationBar: BottomTabNavigator(),
    );
  }
}

Widget _buildOffstageNavigator(TabItem tabItem) {
  IndexController indexController = Get.find();

  return Obx(() => Offstage(
        offstage: indexController.currentIndex.value != tabItem,
        child: bottomTabs[tabItem],
      ));
}
