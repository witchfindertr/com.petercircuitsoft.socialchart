import 'package:cloud_firestore/cloud_firestore.dart';

enum DataSource { internal, external }

class ModelChartData {
  ModelChartData({
    required this.createdAt,
    required this.chartId,
    required this.chartOwner,
    required this.chartName,
    required this.chartType,
    required this.dataSource,
    this.insightCardCounter,
    this.interedtedUserCounter,
  });
  final Timestamp createdAt; //creation time
  final String chartId;
  final String chartOwner; //user email
  final String chartName;
  final String chartType;
  final DataSource dataSource;
  final int? insightCardCounter; // user text reported
  final int? interedtedUserCounter;
  ModelChartData.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          chartId: json['chartId']! as String,
          chartOwner: json['chartOwner'] as String,
          chartName: json['chartName'] as String,
          chartType: json['chartType'] as String,
          dataSource: json['dataSource'] as DataSource,
          insightCardCounter: json['insightCardCounter'] as int?,
          interedtedUserCounter: json['interedtedUserCounter'] as int?,
        );
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'chartId': chartId,
      'chartOwner': chartOwner,
      'chartName': chartName,
      'chartType': chartType,
      'insightCardCounter': insightCardCounter,
      'interedtedUserCounter': interedtedUserCounter,
    };
  }
}