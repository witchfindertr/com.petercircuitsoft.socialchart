import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_report_card.dart';

enum ReportItem {
  sexualContent, //성적인 콘텐츠
  violentContent, //폭력적인 컨텐츠
  hatefulContent, //증오 컨텐츠
  harassmentBullying, //괴롭힘, 폭력
  harmfulDangerousActs, //유해하거나 위험한 행동
  childAbuse, //아동 학대
  misinformation, //유해하거나 잘못된 정보
  spam, //스팸
  infringesRight, //권리 침해
  etc, //기타
}

class ModalScreenReportController extends GetxController {
  ModalScreenReportController({required this.cardId});
  final String cardId;

  final textController = TextEditingController();
  var _report = ReportItem.sexualContent.obs;

  ReportItem get reportItem => _report.value;
  set reportItem(ReportItem value) => _report.value = value;

  Future<DocumentReference<ModelReportCard>> reportCard() async {
    return reportCardColRef().add(
      ModelReportCard(
        createdAt: Timestamp.now(),
        cardId: cardId,
        reportIndex: reportItem.index,
        reporterId: currentUserId!,
        extraUserText: textController.text,
      ),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
