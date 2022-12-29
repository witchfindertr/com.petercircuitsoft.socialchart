import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/text_and_field.dart';
import 'package:socialchart/screens/modal_screen_create_chart/modal_screen_create_chart_controller.dart';

class ModalScreenCreateChart extends GetView<ModalScreenCreateChartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.bodyMedium!.color),
        title: Text(
          "새로운 차트 만들기",
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          CupertinoButton(
            child: Text("저장"),
            onPressed: () => print("todo: 저장하기 기능"),
            padding: EdgeInsets.zero,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            textAndField(
              hintText: "차트 이름을 입력해주세요.",
              text: "차트 이름",
              maxLength: 20,
              controller: controller.chartNameFieldController,
            ),
            textAndField(
              hintText: "차트에 사용할 데이터를 선택해 주세요.",
              text: "차트 데이터",
              maxLength: 20,
              controller: controller.chartNameFieldController,
              counterText: '',
            ),
            DropdownButton(
              value: controller.selected,
              items: controller.chartDataList
                  .map((value) =>
                      DropdownMenuItem(value: value, child: Text(value.name)))
                  .toList(),
              // [
              //   DropdownMenuItem(
              //     value: controller.chartDataList[0],
              //     alignment: Alignment.center,
              //     child: Text("aaaa"),
              //   ),
              //   DropdownMenuItem(
              //     value: controller.chartDataList[1],
              //     alignment: Alignment.center,
              //     child: Text("abbbb"),
              //   ),
              //   DropdownMenuItem(
              //     value: controller.chartDataList[2],
              //     alignment: Alignment.center,
              //     child: Text("cccc"),
              //   ),
              // ],
              onChanged: (value) => print(value),
            ),
            textAndField(
              hintText: "차트 형태를 선택해주세요.",
              text: "추가 차트 데이터",
              maxLength: 20,
              controller: controller.chartNameFieldController,
            ),
          ],
        )),
      ),
    );
  }
}
