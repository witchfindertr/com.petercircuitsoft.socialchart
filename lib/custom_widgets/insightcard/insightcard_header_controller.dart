import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_chart_info.dart';

class InsightCardHeaderController extends GetxController {
  InsightCardHeaderController({required this.chartId});
  final String chartId;

  final _chartInfo = Rxn<ModelChartInfo>();
  ModelChartInfo? get chartInfo => _chartInfo.value;

  Future<DocumentSnapshot<ModelChartInfo>> fetchChartInfo(String chartId) {
    return chartInfoColRef().doc(chartId).get();
  }

  @override
  void onInit() {
    fetchChartInfo(chartId).then((value) {
      _chartInfo.value = value.data();
    }, onError: (e) => print("에러에러!:$e"));
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
