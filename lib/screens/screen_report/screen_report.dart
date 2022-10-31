import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/screens/screen_report/widgets/report_form.dart';
import 'package:socialchart/custom_widgets/text_and_link.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/screens/screen_report/screen_report_controller.dart';

class ScreenReport extends GetView<ScreenReportController> {
  const ScreenReport({super.key, this.navKey});
  final NavKeys? navKey;
  static const routeName = '/ScreenReport';

  @override
  // TODO: implement tag
  String? get tag => navKey?.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("문제 신고하기")),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: Text(
                  "문제가 있으신가요?",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                alignment: Alignment.center,
                child: ReportForm(),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextAndLink(
                          text: "문제가 없으시면 로그인 할까요?",
                          linkText: "👉로그인",
                          linkFunction: () => Get.back(id: navKey?.index),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
