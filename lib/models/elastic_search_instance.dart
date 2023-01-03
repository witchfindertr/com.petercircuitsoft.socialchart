//elastic search
import 'package:elastic_app_search/elastic_app_search.dart';
import 'package:socialchart/models/model_elastic_search.dart';
import 'package:dio/dio.dart';

class ElasticAppSearchInstance {
  final String endPoint;
  final String searchKey;

  late final ElasticAppSearch searchService;

  static const _pageSize = 50;
  ElasticAppSearchInstance({required this.endPoint, required this.searchKey}) {
    searchService = ElasticAppSearch(endPoint: endPoint, searchKey: searchKey);
  }

  Future<List<ModelElasticSearchChartInfo>> searchChartInfo(
      String value, int pageNumber) async {
    ElasticResponse response = await searchService
        .engine("chartinfo")
        .query(value.trim())
        .page(pageNumber, size: _pageSize)
        .sort('interestedusercounter', descending: true)
        .get();
    return response.results.map((e) {
      return ModelElasticSearchChartInfo.fromJson(e.data!);
    }).toList();
  }

  Future<List<ModelElasticSearchDataSets>> searchDataSets(
      String value, int pageNumber) async {
    ElasticResponse response = await searchService
        .engine("datasets")
        .query(value.trim())
        .page(pageNumber, size: _pageSize)
        .sort('interestedusercounter', descending: true)
        .get();
    return response.results.map((e) {
      return ModelElasticSearchDataSets.fromJson(e.data!);
    }).toList();
  }

  //for elastic search click api : there is no click api in the elastic_app_search package
  final Dio dio = Dio();

  void resultClick({
    required String engine,
    required String query,
    required String documentId,
  }) {
    dio.post(
        '${endPoint.toLowerCase()}/api/as/v1/engines/${engine.toLowerCase()}/click',
        data: {
          "query": query,
          "document_id": documentId,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $searchKey",
          },
        ));
  }
}
