import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/ads/google_inline_ads.dart';
import 'package:socialchart/custom_widgets/appbar_buttons.dart';
import 'package:socialchart/custom_widgets/chart_summary_listtile.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/modal_screen_create_chart/modal_screen_create_chart.dart';
import 'package:socialchart/screens/modal_screen_create_chart/modal_screen_create_chart_binding.dart';
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
        body: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            MainSliverAppbar(
              titleText: "Explore",
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              actions: [
                appbarAddChart(
                  () => Get.to(
                    fullscreenDialog: true,
                    binding: ModalScreenCreateChartBinding(),
                    () => ModalScreenCreateChart(),
                  ),
                ),
                appbarSearchButton(
                  id: navKey.index,
                  //todo get to search page
                  // callback: () => print("search button pressed"),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: GoogleInlineAds(
                  tag: "ExploreTop",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 6.4),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "뜨고 있는 차트",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 10),
                    chartSummaryListTile(
                        title: "이더리움",
                        cardCount: 20,
                        userCount: 20,
                        description: "이더리움 업비트 차트"),
                    chartSummaryListTile(
                      title: "이태원 참사",
                      cardCount: 2023,
                      userCount: 20,
                    ),
                    chartSummaryListTile(
                      title: "달러 환율",
                      cardCount: 2023,
                      userCount: 20,
                    ),
                    chartSummaryListTile(
                      title: "금리&주택가격",
                      cardCount: 20,
                      userCount: 20123,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "인기있는 인사이트 카드",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 30),
                    ListTile(
                      title: Text("님의 인사이트 카드"),
                    ),
                    Text("님의 인사이트 카드"),
                    Text("님의 인사이트 카드"),
                    Text("님의 인사이트 카드"),
                    SizedBox(height: 30),
                    Divider(),
                    Text(""),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: GoogleInlineAds(
                tag: "ExploreLast",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 250 / 300,
              ),
            ),
          ],
        ),
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
