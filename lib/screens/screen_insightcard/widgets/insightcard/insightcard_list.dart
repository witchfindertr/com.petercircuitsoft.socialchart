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
    this.scrollToTopEnable = false,
    this.navKey,
    this.userId,
    this.chartId,
    this.header,
  });
  final NavKeys? navKey;
  final bool scrollToTopEnable;
  final String? userId;
  final String? chartId;
  final Widget? header;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InsightCardListController(chartId: chartId, userId: userId),
      tag: "${navKey?.name}${userId ?? ""}${chartId ?? ""}",
      builder: (controller) {
        return Scaffold(
          body: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: header ?? SizedBox(),
              ),
              PagedSliverList(
                pagingController: controller.pageController,
                builderDelegate: PagedChildBuilderDelegate<
                    QueryDocumentSnapshot<InsightCardModel>>(
                  itemBuilder: ((context, item, index) {
                    if (header != null && index == 0) {
                      return header!;
                    }
                    return InsightCard(navKey: navKey, cardInfo: item.data());
                  }),
                ),
              ),
            ],
          ),
          floatingActionButton: Obx(
            () => controller.scrollOffset > 0 && scrollToTopEnable
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

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  MyHeaderDelegate({this.header});
  final Widget? header;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return header ?? SizedBox();
  }

  @override
  double get maxExtent => 264;

  @override
  double get minExtent => 84;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
