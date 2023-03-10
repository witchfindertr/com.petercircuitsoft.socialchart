import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/custom_widgets/ads/google_inline_ads.dart';
import 'package:socialchart/custom_widgets/appbar_buttons.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/modal_screen_write_modify/modal_screen_write_modify.dart';
import 'package:socialchart/screens/modal_screen_write_modify/modal_screen_write_modify_binding.dart';
import 'package:socialchart/screens/screen_chart/chart/chart_persistent_header_delegate.dart';
import 'package:socialchart/screens/screen_chart/screen_chart_controller.dart';

class ScreenChart extends GetView<ScreenChartController> {
  const ScreenChart({
    super.key,
    required this.navKey,
  });
  static const routeName = "/ScreenChart";
  final NavKeys navKey;
  @override
  // TODO: implement tag
  String? get tag => navKey.name;

  Widget floatingButton() {
    return ElevatedButton(
      onPressed: () async {
        var result = await Get.to(
          binding: ModalScreenWriteModifyBinding(chartId: controller.chartId),
          fullscreenDialog: true,
          () => ModalScreenWriteModify(),
          // arguments: controller.chartId,
        );
        if (result == "complete") {
          //if complete => refresh the list
          controller.pagingController.refresh();
        }
      },
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
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    //for function tab to scroll top, scroll controller need to be sent
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey?.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => controller.pagingController.refresh(),
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (!controller.streamController.isClosed &&
                  notification.metrics.axisDirection != AxisDirection.left &&
                  notification.metrics.axisDirection != AxisDirection.right) {
                controller.streamController.add(notification);
                print(notification.metrics.axisDirection);
              }
              return false;
            },
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                MainSliverAppbar(
                  titleText: '${controller.chartId} ??????',
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  actions: [
                    Obx(
                      () => appbarAddButton(
                        controller.toggleAddChart,
                        controller.isChartAdded,
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => SliverPersistentHeader(
                    pinned: true,
                    delegate: ChartPersistentHeaderDelegate(
                      chartId: controller.chartId,
                      cardData: controller.currentInsightCardData,
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ),
                ),
                PagedSliverList.separated(
                  pagingController: controller.pagingController,
                  separatorBuilder: (context, index) {
                    return index != 0 && index % 10 == 0
                        ? Column(
                            children: [
                              Container(
                                color: Theme.of(context).backgroundColor,
                                height: 8,
                              ),
                              GoogleInlineAds(
                                width: MediaQuery.of(context).size.width,
                                tag: "Home$index",
                                height: MediaQuery.of(context).size.width *
                                    250 /
                                    300,
                              ),
                              Container(
                                color: Theme.of(context).backgroundColor,
                                height: 8,
                              ),
                            ],
                          )
                        : Container(
                            color: Theme.of(context).backgroundColor,
                            height: 8,
                          );
                  },
                  builderDelegate: PagedChildBuilderDelegate<
                      QueryDocumentSnapshot<ModelInsightCard>>(
                    itemBuilder: (context, item, index) {
                      return GetBuilder(
                        init: InsightCardController(
                          cardId: item.id,
                          cardInfo: item.data(),
                        ),
                        tag: item.id + routeName,
                        dispose: (state) {
                          controller.removeContextItem(index);
                        },
                        builder: (getController) {
                          return LayoutBuilder(
                            builder: (p0, p1) {
                              controller.addContextItem(
                                  ContextItem(context: p0, index: index));
                              return InsightCard(
                                routeName: routeName,
                                navKey: navKey,
                                showHeader: false,
                                cardId: item.id,
                                cardData: item.data(),
                              );
                            },
                          );
                        },
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "?????? ???????????? ????????? ????????????.",
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                    noMoreItemsIndicatorBuilder: (context) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "????????????????? ???????????? ????????????.????????",
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: floatingButton(),
      ),
    );
  }
}
