import 'dart:convert';
import 'dart:ffi';

class ModelTypesenseResult {
  ModelTypesenseResult({
    this.facet_counts,
    this.found,
    this.out_of,
    this.page,
    this.hits,
    this.request_params,
    this.search_cutoff,
    this.search_time_ms,
  });
  final List<dynamic>? facet_counts;
  final int? found;
  final int? out_of;
  final int? page;
  final List<TypesenseHits>? hits;
  final RequestParameters? request_params;
  final bool? search_cutoff;
  final int? search_time_ms;
  ModelTypesenseResult.fromJson(Map<String, dynamic> json)
      : this(
          facet_counts: json['facet_counts'],
          found: json['found'] as int?,
          out_of: json['out_of'] as int?,
          page: json['page'] as int?,
          hits: List.from(
              json['hits'].map((model) => TypesenseHits.fromJson(model))),
          request_params: RequestParameters.fromJson(json['request_params']),
          search_cutoff: json['search_cutoff'],
          search_time_ms: json['search_time_ms'],
        );
  Map<String, dynamic> toJson() {
    return {
      'facet_counts': facet_counts,
      'found': found,
      'out_of': out_of,
      'page': page,
      'hits': hits,
      'request_params': request_params,
      'search_cutoff': search_cutoff,
      'search_time_ms': search_time_ms,
    };
  }
}

class RequestParameters {
  RequestParameters({
    this.collection_name,
    this.per_page,
    this.q,
  });
  final String? collection_name;
  final int? per_page;
  final String? q;
  RequestParameters.fromJson(Map<String, dynamic> json)
      : this(
          collection_name: json['collection_name'],
          per_page: json['per_page'],
          q: json['q'],
        );
}

class TypesenseDocument {
  TypesenseDocument({
    required this.id,
    required this.name,
    this.description,
  });
  final String? description;
  final String id;
  final String name;
  TypesenseDocument.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          description: json['description'] as String?,
        );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

class TypesenseHits {
  TypesenseHits({
    required this.document,
    required this.highlights,
    required this.text_match,
  });
  final TypesenseDocument document;
  final List<TypesenseHighlight> highlights;
  final int text_match;
  TypesenseHits.fromJson(Map<String, dynamic> json)
      : this(
          document: TypesenseDocument.fromJson(json['document']),
          highlights: List.from(json['highlights']
              .map((model) => TypesenseHighlight.fromJson(model))),
          text_match: json['text_match'] as int,
        );
  Map<String, dynamic> toJson() {
    return {
      'document': document,
      'highlights': highlights,
      'text_match': text_match,
    };
  }
}

class TypesenseHighlight {
  TypesenseHighlight({
    required this.field,
    required this.matched_tokens,
    this.snippet,
  });
  final String? field;
  final List<String>? matched_tokens;
  final String? snippet;
  TypesenseHighlight.fromJson(Map<String, dynamic> json)
      : this(
          field: json['field'] as String?,
          matched_tokens: List.from(
              json['matched_tokens'].map((model) => model.toString())),
          snippet: json['snippet'] as String?,
        );
  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'matched_tokens': matched_tokens,
      'snippet': snippet,
    };
  }
}
