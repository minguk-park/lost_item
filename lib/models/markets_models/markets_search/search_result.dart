import 'package:json_annotation/json_annotation.dart';
import 'package:lost_item/models/markets_models/markets_search/search_result_items.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult {
  SearchResult(this.pageNo, this.pageSize, this.totalCount, this.items);

  @JsonKey(name: 'PageNo')
  int pageNo;

  @JsonKey(name: 'PageSize')
  int pageSize;

  @JsonKey(name: 'TotalCount')
  int totalCount;

  @JsonKey(name: 'Items')
  List<SearchResultItems> items;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
