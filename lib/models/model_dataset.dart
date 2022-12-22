import 'package:cloud_firestore/cloud_firestore.dart';

class ModelDataSet {
  const ModelDataSet({
    required this.createdAt,
    required this.name,
    required this.dataType,
    this.description,
    required this.data,
  });
  final Timestamp createdAt; //creation time
  final String name;
  final String dataType; //user Id
  final List<DataUnit> data;
  final String? description; //

  ModelDataSet.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt'] as Timestamp,
          name: json['name'] as String,
          dataType: json['dataType'] as String,
          description: json['description'] as String?,
          data: json['data'] as List<DataUnit>,
        );
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'name': name,
      'dataType': dataType,
      'description': description,
      'data': data,
    };
  }
}

class DataUnit<T> {
  const DataUnit({
    required this.time,
    required this.value,
  });
  final Timestamp time;
  final T value;
  DataUnit.fromJson(Map<String, Object?> json)
      : this(
          time: json['time'] as Timestamp,
          value: json['value'] as T,
        );
  Map<String, Object?> toJson() {
    return {
      'time': time,
      'value': value,
    };
  }
}
