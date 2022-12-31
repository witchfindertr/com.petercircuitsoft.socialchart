import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/chart_summary_listtile.dart';
import 'package:socialchart/custom_widgets/gradient_mask.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/custom_widgets/text_and_field.dart';
import 'package:socialchart/screens/modal_screen_search/modal_screen_search_controller.dart';
import 'package:socialchart/screens/screen_chart/screen_chart.dart';
import 'package:typesense/typesense.dart';

class ModalScreenSearch extends GetView<ModalScreenSearchController> {
  ModalScreenSearch({required this.navigatorId});
  final int navigatorId;
  @override
  Widget build(BuildContext context) {
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
          onChanged: (value) => controller.getSearchResult(value),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Obx(
          () => Container(
            // color: Colors.blueGrey,
            child: ListView.builder(
              itemCount: controller.chartList.length,
              itemBuilder: (context, index) {
                return chartSummaryListTile(
                  title: controller.chartList[index].name,
                  description: controller.chartList[index].description,
                  tapCallback: () {
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
        ),
      ),
    );
  }
}
