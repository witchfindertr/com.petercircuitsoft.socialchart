import 'package:cloud_firestore/cloud_firestore.dart';

class ModelDataSet<T> {
  const ModelDataSet({
    required this.id,
    required this.createdAt,
    required this.author,
    required this.name,
    this.dataType,
    this.description,
    required this.eventData,
  });
  //document creation time
  final Timestamp createdAt; //creation time

  final String id;
  //firebase user id
  final String author;

  ///dataset name
  final String name;

  ///dataType "number" or "string"
  final String? dataType;

  ///actual data of this class
  final List<EventData<T>> eventData;

  ///description for the dataset
  final String? description;

  ModelDataSet.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String,
          createdAt: json['createdAt'] as Timestamp,
          name: json['name'] as String,
          author: json['author'] as String,
          dataType: json['dataType'] as String,
          description: json['description'] as String?,
          eventData: json['eventData'] as List<EventData<T>>,
        );
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'name': name,
      'author': author,
      'dataType': dataType,
      'description': description,
      'eventData': eventData,
    };
  }

  //addEvent
  void addEvent(EventData<T> newEvent) {
    int index = eventData.indexWhere(
      (event) => event.date.toDate().isAfter(
            newEvent.date.toDate(),
          ),
    );
    if (index == -1) {
      eventData.add(newEvent);
    } else {
      eventData.insert(index, newEvent);
    }
  }

  void removeEvent(int index) => eventData.removeAt(index);

  void orderEvent() => eventData.sort(
        (a, b) => a.date.compareTo(b.date),
      );
}

class EventData<T> {
  const EventData({
    required this.createdAt,
    required this.date,
    required this.value,
  });

  final Timestamp createdAt;
  final Timestamp date;
  final T value;
  EventData.fromJson(Map<String, Object?> json)
      : this(
          createdAt: json['createdAt'] as Timestamp,
          date: json['date'] as Timestamp,
          value: json['value'] as T,
        );
  Map<String, Object?> toJson() {
    return {
      'createdAt': createdAt,
      'date': date,
      'value': value,
    };
  }
}
