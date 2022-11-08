import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/insightcard/insightcard_list_controller.dart';
import './insightcard.dart';

class InsightCardList extends StatelessWidget {
  const InsightCardList({
    super.key,
    this.navKey,
  });
  final NavKeys? navKey;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InsightCardListController(),
      builder: (controller) {
        return Scaffold(
          body: PagedListView(
            scrollController: controller.scrollController,
            pagingController: controller.pageController,
            builderDelegate: PagedChildBuilderDelegate<
                QueryDocumentSnapshot<InsightCardModel>>(
              itemBuilder: ((context, item, index) {
                return InsightCard(navKey: navKey, cardInfo: item.data());
              }),
            ),
          ),
          floatingActionButton: Obx(
            () => controller.scrollOffset > 0
                ? TextButton(
                    onPressed: () {
                      controller.scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    },
                    child: Icon(Icons.arrow_upward),
                  )
                : SizedBox(),
          ),
        );
      },
    );
  }
}
