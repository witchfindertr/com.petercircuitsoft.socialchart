class ModelElasticSearchChartInfo {
  ModelElasticSearchChartInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.insightCardCounter,
    required this.interestedUserCounter,
  });
  final String id;
  final String name;
  final String? description;
  final int insightCardCounter;
  final int interestedUserCounter;

  ModelElasticSearchChartInfo.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          description: json['description'] as String?,
          insightCardCounter: json['insightcardcounter'] == null
              ? 0
              : (json['insightcardcounter'] as double).toInt(),
          interestedUserCounter: json['interestedusercounter'] == null
              ? 0
              : (json['interestedusercounter'] as double).toInt(),
        );

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "desciprtion": description,
      "insightCardCounter": insightCardCounter,
      "interestedUserCounter": interestedUserCounter,
    };
  }
}

class ModelElasticSearchDataSets {
  ModelElasticSearchDataSets(
      {required this.name, required this.description, this.data});
  final String? name;
  final String? description;
  final List<dynamic>? data;

  ModelElasticSearchDataSets.fromJson(Map<String, Object?> json)
      : this(
          name: json['name'] as String?,
          description: json['description'] as String?,
          data: json['data'] as List<dynamic>?,
        );

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "desciprtion": description,
      "data": data,
    };
  }
}
