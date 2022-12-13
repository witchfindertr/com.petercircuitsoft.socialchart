import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_explore/screen_explore_controller.dart';

class ScreenExplore extends GetView<ScreenExploreController> {
  const ScreenExplore({super.key, required this.navKey});
  final NavKeys navKey;
  static const routeName = '/ScreenExplore';

  @override
  // TODO: implement tag
  String? get tag => navKey.name;
  @override
  Widget build(BuildContext context) {
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        appBar: MainAppBar(appBar: AppBar(), title: "Explore"),
        body: Text("explore"),
        // body: InsightCardList(
        //   scrollController: controller.scrollController,
        //   sliverAppBar: MainSliverAppbar(
        //     titleText: "Explore",
        //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   ),
        //   navKey: navKey,
        //   scrollToTopEnable: true,
        // ),
      ),
    );
  }
}
