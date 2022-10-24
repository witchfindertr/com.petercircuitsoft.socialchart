import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/reportController.dart';
import 'package:socialchart/customWidgets/ReportForm.dart';
import 'package:socialchart/customWidgets/TextAndLink.dart';

class ScreenReport extends StatefulWidget {
  const ScreenReport({super.key});

  @override
  State<ScreenReport> createState() => _ScreenReportState();
}

class _ScreenReportState extends State<ScreenReport> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(ReportController());
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
                          text: "문제가 없으시면 ",
                          linkText: "👉로그인",
                          linkFunction: () => Navigator.popUntil(
                              context, (route) => route.isFirst),
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
