import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_report.dart';

class ScreenReportController extends GetxController {
  static ScreenReportController get to => Get.find();

  var key = GlobalKey<FormState>();
  var textController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void onInit() {
    print("init");
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> sendReport(String userEmail, userMessage) {
    return userReportColRef()
        .add(ModelUserReport(
            userEmail: userEmail,
            userMessage: userMessage,
            createdAt: Timestamp.now(),
            isReplied: false))
        .then((value) => print("send complete"))
        .catchError((onError) {
      print("에러요!, ${onError}");
      throw (onError);
    });
  }
}
