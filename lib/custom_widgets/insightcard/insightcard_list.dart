import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_list_controller.dart';
import 'package:socialchart/screens/screen_chart/chart/chart_persistent_header_delegate.dart';
import './insightcard.dart';

class InsightCardList extends StatelessWidget {
  const InsightCardList({
    super.key,
    this.sliverAppBar,
    this.scrollController,
    this.scrollToTopEnable = false,
    this.navKey,
    this.userId,
    this.chartId,
    this.showCardHeader,
    this.persistentHeader,
  });
  final Widget? sliverAppBar;
  final NavKeys? navKey;
  final ScrollController? scrollController;
  final bool scrollToTopEnable;
  final String? userId;
  final String? chartId;
  final bool? showCardHeader;
  final Widget? persistentHeader;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InsightCardListController(chartId: chartId, userId: userId),
      tag: "${navKey?.name}${userId ?? ""}${chartId ?? ""}",
      builder: (controller) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
              () => controller.pagingController.refresh(),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                sliverAppBar ?? const SliverToBoxAdapter(child: SizedBox()),
                persistentHeader ?? const SliverToBoxAdapter(child: SizedBox()),
                // SliverPersistentHeader(
                //   delegate: persistentHeader ?? const SizedBox(),
                //   // pinned: true,
                // ),
                // SliverToBoxAdapter(
                //   child: persistentHeaderDelegate ?? const SizedBox(),
                // ),
                PagedSliverList(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<
                      QueryDocumentSnapshot<ModelInsightCard>>(
                    itemBuilder: ((context, item, index) {
                      return GetBuilder(
                        init: InsightCardController(
                            userId: item.data().author.id,
                            cardId: item.id,
                            cardInfo: item.data()),
                        tag: item.id,
                        builder: (controller) {
                          return InsightCard(
                            navKey: navKey,
                            showHeader: showCardHeader ?? true,
                            cardId: item.id,
                            cardInfo: item.data(),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
