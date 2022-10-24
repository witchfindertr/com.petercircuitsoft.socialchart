import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/userReport.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class ReportController extends GetxController {
  static ReportController get to => Get.find();
  final userReportColRef = firestore.collection("userReports").withConverter(
      fromFirestore: (snapshot, options) =>
          UserReport.fromJson(snapshot.data()!),
      toFirestore: ((value, options) => value.toJson()));
  Future<void> sendReport(String userEmail, userMessage) {
    return userReportColRef
        .add(UserReport(
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
