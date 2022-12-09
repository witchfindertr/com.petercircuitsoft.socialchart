import 'package:cloud_firestore/cloud_firestore.dart';

class ModelChartList {
  const ModelChartList({
    required this.chartId,
    required this.createdAt,
  });
  final String chartId; //user Id
  final Timestamp createdAt; //creation time

  ModelChartList.fromJson(Map<String, Object?> json)
      : this(
          chartId: json['chartId'] as String,
          createdAt: json['createdAt'] as Timestamp,
        );
  Map<String, Object?> toJson() {
    return {
      'chartId': chartId,
      'createdAt': createdAt,
    };
  }
}
