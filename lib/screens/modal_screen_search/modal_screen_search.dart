import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/chart_summary_listtile.dart';
import 'package:socialchart/screens/modal_screen_search/modal_screen_search_controller.dart';
import 'package:socialchart/screens/screen_chart/screen_chart.dart';

class ModalScreenSearch extends GetView<ModalScreenSearchController> {
  ModalScreenSearch({required this.navigatorId});
  final int navigatorId;
  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).appBarTheme);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: CupertinoButton(
            child: Icon(CupertinoIcons.back), onPressed: () => Get.back()),
        title: TextField(
          controller: controller.searchFieldController,
          decoration: InputDecoration(
            alignLabelWithHint: false,
            hintText: "차트 검색",
            // hintStyle: TextStyle(color: Colors.blueAccent),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          onChanged: (value) => controller.getSearchResult(value, 1),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                // color: Colors.blueGrey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.searchFieldController.text.trim().isEmpty
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '\'${controller.searchFieldController.text.trim()}\'로 검색한 결과',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                  Flexible(
                    child: ListView.separated(
                      itemCount: controller.chartList.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 2,
                        );
                      },
                      itemBuilder: (context, index) {
                        return CharSummaryListTile(
                          title: controller.chartList[index].name,
                          description: controller.chartList[index].description,
                          userCount:
                              controller.chartList[index].interestedUserCounter,
                          cardCount:
                              controller.chartList[index].insightCardCounter,
                          tapCallback: () {
                            controller.searchInstance.resultClick(
                                engine: 'chartinfo',
                                documentId: controller.chartList[index].id,
                                query: controller.searchFieldController.text);
                            //close itself
                            Get.back();
                            //navigate to Screen chart
                            Get.toNamed(
                              ScreenChart.routeName,
                              preventDuplicates: true,
                              id: navigatorId,
                              arguments: controller.chartList[index].id,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
