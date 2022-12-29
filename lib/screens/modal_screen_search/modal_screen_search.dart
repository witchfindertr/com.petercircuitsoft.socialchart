import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/text_and_field.dart';
import 'package:socialchart/screens/modal_screen_search/modal_screen_search_controller.dart';

class ModalScreenSearch extends GetView<ModalScreenSearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.bodyMedium!.color),
        title: Text(
          'ModalScreenSearchPage',
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            textAndField(
                text: "Search", controller: controller.searchFieldController),
            Obx(
              () => controller.chartList != null
                  ? Flexible(
                      child: Container(
                        color: Colors.blueGrey,
                        child: ListView.builder(
                          itemCount: controller.chartList?.length,
                          itemBuilder: (context, index) {
                            return Text(controller.chartList![index].name);
                          },
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
            Obx(
              () => controller.dataSetList != null
                  ? Flexible(
                      child: Container(
                        color: Colors.amber,
                        child: ListView.builder(
                          itemCount: controller.dataSetList?.length,
                          itemBuilder: (context, index) {
                            return Text(controller.dataSetList![index].name);
                          },
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
