//todo hold
class DataSetList {
  DataSetList({
    required this.dataSetId,
    required this.dataSetName,
    this.dataSetDescription,
  });
  final String dataSetId;
  final String dataSetName;
  final String? dataSetDescription;
}
