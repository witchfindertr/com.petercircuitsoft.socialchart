import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/screens/screen_home/screen_home_controller.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/insightcard/insightcard.dart';

class ScreenHome extends GetView<ScreenHomeController> {
  const ScreenHome({super.key, this.navKey});
  final NavKeys? navKey;
  static const routeName = '/ScreenHome';

  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), title: "Social Chart"),
      body: PagedListView(
        // primary: true,
        scrollController: controller.scrollController,
        pagingController: controller.pageController,
        builderDelegate:
            PagedChildBuilderDelegate<QueryDocumentSnapshot<InsightCardModel>>(
          itemBuilder: ((context, item, index) {
            return InsightCard(navKey: navKey, cardInfo: item.data());
          }),
        ),
      ),
      floatingActionButton: TextButton(
          onPressed: () {
            controller.scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear, // TODO(ianh): Use a more appropriate curve.
            );
          },
          child: Icon(Icons.arrow_upward)),
    );
  }
}
