import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'HomeNavigator.dart';
import 'ExploreNavigator.dart';
import 'ProfileNavigator.dart';
import 'NoticeNavigator.dart';

enum TabItem { home, explore, notice, profile }

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    required this.name,
    required this.icon,
    required this.index,
    required this.widget,
  });

  final String name;
  final IconData icon;
  final int index;
  final Widget widget;
  // final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}

const Map<TabItem, TabNavigator?> tabNavigators = {
  TabItem.home: TabNavigator(
    name: "홈",
    icon: Icons.home,
    index: 0,
    widget: HomeNavigator(),
  ),
  TabItem.explore: TabNavigator(
    name: "탐색",
    icon: Icons.search,
    index: 1,
    widget: ExploreNavigator(),
  ),
  TabItem.notice: TabNavigator(
      name: "알림",
      icon: Icons.notifications_none,
      index: 2,
      widget: NoticeNavigator()),
  TabItem.profile: TabNavigator(
    name: "내정보",
    icon: Icons.person,
    index: 3,
    widget: ProfileNavigator(),
  ),
};
