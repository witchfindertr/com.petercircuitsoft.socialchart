import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socialchart/models/nouse_model_typesense_result.dart';
import 'package:typesense/typesense.dart';

class TypesenseSearchInstance {
  late final config;
  late final client;

  TypesenseSearchInstance() {
    config = Configuration(
      dotenv.env['TYPESENSE_KEY']!,
      nodes: {
        Node(
          Protocol.https,
          dotenv.env['TYPESENSE_HOST']!,
          port: int.parse(dotenv.env['TYPESENSE_PORT']!),
        )
      },
    );
    client = Client(config);
  }
  Future<List<TypesenseHits>?> searchChart(
      String text, String fieldNames) async {
    final searchParameters = {
      'q': text,
      'query_by': fieldNames,
    };
    try {
      var result = await client
          .collection("chartInfo")
          .documents
          .search(searchParameters);
      var searchResult = ModelTypesenseResult.fromJson(result);
      return searchResult.hits;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<TypesenseHits>?> searchDatasets(
      String text, String fieldNames) async {
    final searchParameters = {
      'q': text,
      'query_by': fieldNames,
    };
    try {
      var result = await client
          .collection("dataSets")
          .documents
          .search(searchParameters);
      var searchResult = ModelTypesenseResult.fromJson(result);
      return searchResult.hits;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
