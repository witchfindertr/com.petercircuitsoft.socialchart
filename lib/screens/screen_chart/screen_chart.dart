import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_list.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_list_controller.dart';
import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_chart/chart/chart_persistent_header_delegate.dart';
import 'package:socialchart/screens/screen_chart/screen_chart_controller.dart';
import 'package:socialchart/screens/screen_write/screen_write.dart';

class ScreenChart extends GetView<ScreenChartController> {
  const ScreenChart({super.key, this.navKey});
  static const routeName = "/ScreenChart";
  final NavKeys? navKey;
  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  Widget addInterestedButton() {
    return CupertinoButton(
      onPressed: () => controller.toggleAddChart(),
      child: LinearGradientMask(
        child: Obx(
          () => Icon(
            controller.isChartAdded
                ? CupertinoIcons.check_mark
                : CupertinoIcons.add,
            size: 26,
          ),
        ),
      ),
    );
  }

  Widget floatingButton() {
    return ElevatedButton(
      onPressed: () async {
        var result = await Get.toNamed(ScreenWrite.routeName,
            id: NavKeys.home.index, arguments: controller.chartId);
        if (result == "complete") {
          //if complete => refresh the list
          Get.find<InsightCardListController>(
                  tag: "${navKey?.name}${controller.chartId}")
              .pagingController
              .refresh();
        }
      },
      child: Icon(Icons.add),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size?>(
          Size(60, 60),
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Colors.blue.withOpacity(0.5);
            return null; // Use the component's default.
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey?.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => controller.pagingController.refresh(),
          ),
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              MainSliverAppbarEx(
                titleText: '${controller.chartId} 차트',
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                actions: [
                  addInterestedButton(),
                ],
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: ChartPersistentHeaderDelegate(time: Timestamp.now()),
              ),
              PagedSliverList(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<
                    QueryDocumentSnapshot<ModelInsightCard>>(
                  itemBuilder: (context, item, index) {
                    return GetBuilder(
                      init: InsightCardController(
                        userId: item.data().author.id,
                        cardId: item.id,
                        cardInfo: item.data(),
                      ),
                      tag: item.id,
                      builder: (controller) {
                        return InsightCard(
                          navKey: navKey,
                          showHeader: false,
                          cardId: item.id,
                          cardInfo: item.data(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: floatingButton(),
      ),
    );
  }
}
