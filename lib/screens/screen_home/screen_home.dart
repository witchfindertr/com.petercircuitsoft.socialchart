import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/custom_widgets/ads/google_inline_ads.dart';
import 'package:socialchart/custom_widgets/appbar_buttons.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';

import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/modal_screen_search/modal_screen_search.dart';
import 'package:socialchart/screens/modal_screen_search/modal_screen_search_binding.dart';
import 'package:socialchart/screens/screen_home/screen_home_controller.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard.dart';

import 'package:socialchart/utils/etc.dart';

class ScreenHome extends GetView<ScreenHomeController> {
  const ScreenHome({super.key, required this.navKey});
  final NavKeys navKey;
  static const routeName = '/ScreenHome';

  @override
  String? get tag => navKey.name;

  @override
  Widget build(BuildContext context) {
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        // appBar: MainAppBar(appBar: AppBar(), title: "Social Chart"),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => controller.pagingController.refresh(),
          ),
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              MainSliverAppbar(
                titleText: 'Social Chart',
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                actions: [
                  appbarSearchButton(id: navKey.index),
                ],
              ),
              // SliverToBoxAdapter(
              //   child: Card(
              //     child: GoogleInlineAds(
              //       width: MediaQuery.of(context).size.width,
              //       tag: "HomeMain",
              //       height: MediaQuery.of(context).size.width * 250 / 300,
              //     ),
              //   ),
              // ),
              PagedSliverList.separated(
                pagingController: controller.pagingController,
                separatorBuilder: (context, index) {
                  // return Container(
                  //   color: Theme.of(context).backgroundColor,
                  //   height: 8,
                  // );
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
                              height:
                                  MediaQuery.of(context).size.width * 250 / 300,
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
                    // Get.put<InsightCardController>(InsightCardController(
                    //     cardId: item.id, cardInfo: item.data()),tag:item.id + routeName);
                    // if(index != 0 && index % 10 == 0) return

                    return GetBuilder<InsightCardController>(
                      init: InsightCardController(
                        cardId: item.id,
                        cardInfo: item.data(),
                        refreshFunction: () => controller.refreshList(),
                      ),
                      tag: item.id + routeName,
                      builder: (controller) {
                        // return Column(
                        //   children: [
                        //     index != 0 && index % 10 == 0
                        //         ? Column(children: [
                        //             Card(
                        //               child: GoogleInlineAds(
                        //                 width:
                        //                     MediaQuery.of(context).size.width,
                        //                 tag: "Home$index",
                        //                 height:
                        //                     MediaQuery.of(context).size.width *
                        //                         250 /
                        //                         300,
                        //               ),
                        //             ),
                        //             Container(
                        //               color: Theme.of(context).backgroundColor,
                        //               height: 8,
                        //             )
                        //           ])
                        //         : SizedBox(),
                        return InsightCard(
                          routeName: routeName,
                          navKey: navKey,
                          showHeader: true,
                          cardId: item.id,
                          cardData: item.data(),
                          // )
                          // ],
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
                        "??????????? ?????? ???????????? ????????? ????????????.????????",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // body: InsightCardList(
        //   scrollController: controller.scrollController,
        //   sliverAppBar: MainSliverAppbar(
        //     titleText: "Social Chart",
        //   ),
        //   navKey: navKey,
        //   scrollToTopEnable: true,
        // ),
      ),
    );
  }
}
