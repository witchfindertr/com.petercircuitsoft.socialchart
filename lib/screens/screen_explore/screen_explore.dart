import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/appbar_buttons.dart';
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

  Widget upChartTile(
      {required String title,
      String? description,
      int? userCount,
      int? cardCount}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      isThreeLine: description != null ? true : false,
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          description != null ? Text(description) : SizedBox(),
          Text(
            "관심 사용자: ${userCount ?? 0}, 인사이트 카드 수: ${cardCount ?? 0}",
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement tag
  String? get tag => navKey.name;
  @override
  Widget build(BuildContext context) {
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        // appBar: MainAppbar(
        //   titleText: "Explore",
        //   elevation: 0,
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // ),
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
                  //todo get to search page
                  callback: () => print("search button pressed"),
                )
              ],
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
                    upChartTile(
                        title: "이더리움",
                        cardCount: 20,
                        userCount: 20,
                        description: "이더리움 업비트 차트"),
                    upChartTile(
                      title: "이태원 참사",
                      cardCount: 2023,
                      userCount: 20,
                    ),
                    upChartTile(
                      title: "달러 환율",
                      cardCount: 2023,
                      userCount: 20,
                    ),
                    upChartTile(
                      title: "금리&주택가격",
                      cardCount: 20,
                      userCount: 20123,
                    ),
                    SizedBox(height: 20),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(color: Colors.amber, child: Text("광고")),
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
