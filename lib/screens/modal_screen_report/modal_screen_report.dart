import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/appbar_buttons.dart';
import 'package:socialchart/custom_widgets/linear_gradient_mask.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/screens/modal_screen_report/modal_screen_report_controller.dart';
import 'package:socialchart/screens/screen_report/widgets/report_text_formfield.dart';

class ModalScreenReport extends GetView<ModalScreenReportController> {
  ModalScreenReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        leading: LinearGradientMask(
          child: CupertinoButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              CupertinoIcons.xmark,
            ),
          ),
        ),
        titleText: "게시물 신고하기",
        actions: [
          // Obx(
          appbarSendButton(
            () {
              controller.reportCard().then(
                (value) {
                  Get.back();
                  Get.snackbar("완료", "신고가 완료되었습니다.");
                },
              );
            },
          ),
          // ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(children: [
            ListTile(
              title: Text("성적인 콘텐츠"),
              leading: Radio(
                  value: ReportItem.sexualContent,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            ListTile(
              title: Text("폭력적인 콘텐츠"),
              leading: Radio(
                  value: ReportItem.violentContent,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            ListTile(
              title: Text("증오 콘텐츠"),
              leading: Radio(
                  value: ReportItem.hatefulContent,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            ListTile(
              title: Text("괴롭힘, 폭력"),
              leading: Radio(
                  value: ReportItem.harassmentBullying,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            ListTile(
              title: Text("유해하거나 위험한 행동"),
              leading: Radio(
                  value: ReportItem.harmfulDangerousActs,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            ListTile(
              title: Text("잘못된 정보"),
              leading: Radio(
                  value: ReportItem.misinformation,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            ListTile(
              title: Text("스팸"),
              leading: Radio(
                  value: ReportItem.spam,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            ListTile(
              title: Text("아동 학대"),
              leading: Radio(
                  value: ReportItem.childAbuse,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            ListTile(
              title: Text("권리 침해"),
              leading: Radio(
                  value: ReportItem.infringesRight,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            ListTile(
              title: Text("기타"),
              leading: Radio(
                  value: ReportItem.etc,
                  groupValue: controller.reportItem,
                  onChanged: (value) => {controller.reportItem = value!}),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: controller.textController,
                maxLines: 3,
                decoration: const InputDecoration(
                  helperText: '',
                  helperStyle: TextStyle(height: 1),
                  hintMaxLines: 2,
                  hintText: "(옵션) 추가하실 내용을 입력해주세요.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
