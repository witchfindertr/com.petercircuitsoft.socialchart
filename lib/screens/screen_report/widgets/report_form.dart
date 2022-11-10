import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/email_text_formfield.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/main.dart';
import 'package:socialchart/screens/screen_report/widgets/report_text_formfield.dart';
import 'package:socialchart/screens/screen_report/screen_report_controller.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';

class ReportForm extends StatelessWidget {
  const ReportForm({super.key, this.navKey});
  final NavKeys? navKey;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ScreenReportController>(tag: navKey?.name);
    return Container(
      child: Form(
        key: controller.key,
        child: Column(
          children: [
            EmailTextFormField(
              emailController: controller.emailController,
              hintMessage: "회신받으실 이메일을 입력해주세요.",
            ),
            ReportTextFormField(
                textController: controller.textController, maxLine: 10),
            ElevatedButton(
                onPressed: () {
                  var loading = SocialChartController.to;
                  loading.showFullScreenLoadingIndicator = true;

                  if (controller.key.currentState!.validate()) {
                    //todo 전송
                    controller
                        .sendReport(controller.emailController.text,
                            controller.textController.text)
                        .then((value) {
                      loading.showFullScreenLoadingIndicator = false;
                      Get.snackbar("전송 완료", "말씀해주신 내용이 전송되었어요.");
                      // Navigator.popUntil(context, (route) => route.isFirst);
                      controller.textController.clear();
                      controller.emailController.clear();
                    }).catchError((onError) {
                      print("에러요!${onError}");
                      Get.snackbar("에러요!", "죄송해요. 뭔가 잘못되었어요.");
                      loading.showFullScreenLoadingIndicator = false;
                    });
                  } else {
                    loading.showFullScreenLoadingIndicator = false;
                    if (!Get.isSnackbarOpen) {
                      Get.snackbar("오류", "입력에 오류가 있어요.", isDismissible: true);
                    }
                  }
                },
                child: Text("전송하기")),
          ],
        ),
      ),
    );
  }
}
