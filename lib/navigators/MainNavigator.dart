import 'package:flutter/material.dart';
import 'package:socialchart/controllers/userProfileController.dart';
import 'package:socialchart/navigators/HomeNavigator.dart';
import 'package:socialchart/navigators/ProfileNavigator.dart';
import 'BottomTabNavigator.dart';

import 'NavigationTree.dart';

import 'package:get/get.dart';

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    IndexController indexController = Get.put(IndexController());
    // UserProfileController userProfileController =
    //     Get.put(UserProfileController());
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => Offstage(
                offstage: indexController.currentIndex.value != TabItem.home,
                child: HomeNavigator(),
              )),
          // _buildOffstageNavigator(TabItem.home),
          _buildOffstageNavigator(TabItem.explore),
          _buildOffstageNavigator(TabItem.notice),
          _buildOffstageNavigator(TabItem.profile),
          // Obx(() => Offstage(
          //       offstage: indexController.currentIndex.value != TabItem.profile,
          //       child: ProfileNavigator(),
          //     )),
        ],
      ),
      bottomNavigationBar: const BottomTabNavigator(),
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
