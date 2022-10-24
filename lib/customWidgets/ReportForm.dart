import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/controllers/isLoadingController.dart';
import 'package:socialchart/controllers/reportController.dart';
import 'package:socialchart/customWidgets/EmailTextFormField.dart';
import 'package:socialchart/customWidgets/ReportTextFormField.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _emailController = TextEditingController();
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            EmailTextFormField(
                emailController: _emailController,
                hintMessage: "회신받으실 이메일을 입력해주세요."),
            ReportTextFormField(textController: _textController, maxLine: 10),
            ElevatedButton(
                onPressed: () {
                  IsLoadingController.to.isLoading = true;

                  if (_formKey.currentState!.validate()) {
                    //todo 전송
                    ReportController.to
                        .sendReport(_emailController.text, _textController.text)
                        .then((value) {
                      IsLoadingController.to.isLoading = false;
                      Get.snackbar("전송 완료", "말씀해주신 내용이 전송되었어요.");
                    }).catchError((onError) {
                      print("에러요!${onError}");
                      Get.snackbar("에러요!", "죄송해요. 뭔가 잘못되었어요.");
                      IsLoadingController.to.isLoading = false;
                    });
                  } else {
                    IsLoadingController.to.isLoading = false;
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
