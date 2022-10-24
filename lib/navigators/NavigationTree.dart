import 'package:flutter/material.dart';
import 'package:socialchart/screens/ScreenReport.dart';
import 'package:socialchart/screens/ScreenLogin.dart';
import 'package:socialchart/screens/ScreenTest.dart';

//Tab navigator
import 'TabNavigator.dart';

//Screens
import 'package:socialchart/screens/ScreenHome.dart';
import 'package:socialchart/screens/ScreenExplore.dart';
import 'package:socialchart/screens/ScreenNotice.dart';
import 'package:socialchart/screens/ScreenProfile.dart';
import 'package:socialchart/screens/ScreenChart.dart';
import 'package:socialchart/screens/ScreenInsightCard.dart';

enum TabItem { home, explore, notice, profile }

class ScreenRoute {
  const ScreenRoute({required this.path, required this.screen});
  final String path;
  final Widget screen;
}

class BottomTab extends StatelessWidget {
  const BottomTab({
    required this.name,
    required this.icon,
    required this.index,
    required this.routes,
  });

  final String name;
  final IconData icon;
  final int index;
  final List<ScreenRoute> routes;
  // final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      routes: routes,
    );
  }
}

const Map<TabItem, BottomTab?> bottomTabs = {
  TabItem.home: BottomTab(
    name: "홈",
    icon: Icons.home,
    index: 0,
    routes: [
      ScreenRoute(path: '/', screen: ScreenHome()),
      ScreenRoute(path: '/ScreenHome', screen: ScreenHome()),
      ScreenRoute(path: '/ScreenInsightCard', screen: ScreenInsightCard()),
      ScreenRoute(path: '/ScreenChart', screen: ScreenChart()),
    ],
  ),
  TabItem.explore: BottomTab(
    name: "탐색",
    icon: Icons.search,
    index: 1,
    routes: [
      ScreenRoute(path: '/', screen: ScreenExplore()),
      ScreenRoute(path: '/ScreenExplore', screen: ScreenExplore()),
    ],
  ),
  TabItem.notice: BottomTab(
    name: "알림",
    icon: Icons.notifications_none,
    index: 2,
    routes: [
      ScreenRoute(path: '/', screen: ScreenNotice()),
      ScreenRoute(path: '/ScreenNotice', screen: ScreenNotice()),
    ],
  ),
  TabItem.profile: BottomTab(
    name: "내정보",
    icon: Icons.person,
    index: 3,
    routes: [
      ScreenRoute(path: '/', screen: ScreenProfile()),
      ScreenRoute(path: '/ScreenProfile', screen: ScreenProfile()),
    ],
  ),
};

const List<ScreenRoute> loginRoutes = [
  ScreenRoute(path: '/', screen: ScreenLogin()),
  ScreenRoute(path: '/ScreenLogin', screen: ScreenLogin()),
  ScreenRoute(path: '/ScreenReport', screen: ScreenReport()),
  ScreenRoute(path: '/ScreenTest', screen: ScreenTest()),
];
