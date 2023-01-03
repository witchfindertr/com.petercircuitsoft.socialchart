import 'package:cloud_firestore/cloud_firestore.dart';

enum ChartType { line, event }

class ModelChartInfo {
  ModelChartInfo({
    required this.createdAt,
    required this.id,
    required this.authorId,
    required this.name,
    required this.type,
    required this.eventDataIds,
    this.description,
    this.insightCardCounter = 0,
    this.interestedUserCounter = 0,

    //last event description String
    //last event summary List<String>
  });

  ///creation time
  final Timestamp createdAt; //creation time
  ///chart id
  final String id;

  ///chart author id
  final String authorId; //user email
  ///chart display name
  final String name;

  ///chart type
  ///line chart, event chart
  final ChartType type;

  /// eventDataIds[0]: representative events
  final List<String> eventDataIds;

  ///description for the chart
  final String? description;
  final int? insightCardCounter; // user text reported
  final int? interestedUserCounter;

  ModelChartInfo.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt']! as Timestamp,
          id: json['id']! as String,
          authorId: json['authorId'] as String,
          name: json['name'] as String,
          type: ChartType.values.firstWhere(
              (element) => element.toString() == "ChartType.${json["type"]}"),
          description: json['description'] as String?,
          eventDataIds: (json['eventDataIds'] == null
                  ? []
                  : json['eventDataIds'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
          insightCardCounter: json['insightCardCounter'] as int?,
          interestedUserCounter: json['interestedUserCounter'] as int?,
        );
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'id': id,
      'author': authorId,
      'name': name,
      'type': type.toString().split('.').last,
      'description': description,
      'eventDataIds': eventDataIds,
      'insightCardCounter': insightCardCounter,
      'interestedUserCounter': interestedUserCounter,
    };
  }
}
