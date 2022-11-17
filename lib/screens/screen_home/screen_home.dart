import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_home/screen_home_controller.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_list.dart';

class ScreenHome extends GetView<ScreenHomeController> {
  const ScreenHome({super.key, required this.navKey});
  final NavKeys navKey;
  static const routeName = '/ScreenHome';

  @override
  // TODO: implement tag
  String? get tag => navKey.name;

  @override
  Widget build(BuildContext context) {
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        // appBar: MainAppBar(appBar: AppBar(), title: "Social Chart"),
        body: InsightCardList(
          scrollController: controller.scrollController,
          sliverAppBar: MainSliverAppbar(
            titleText: "Social Chart",
          ),
          navKey: navKey,
          scrollToTopEnable: true,
        ),
      ),
    );
  }
}
