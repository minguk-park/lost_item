import 'package:json_annotation/json_annotation.dart';

part 'searchResultItems.g.dart';

@JsonSerializable()
class SearchResultItems {
  SearchResultItems(
    this.id,
    this.name,
    this.grade,
    this.icon,
    this.bundleCount,
    this.tradeRemainCount,
    this.yDayAvgPrice,
    this.recentPrice,
    this.currentMinPrice,
  );

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'Name')
  String name;

  @JsonKey(name: 'Grade')
  String grade;

  @JsonKey(name: 'Icon')
  String icon;

  @JsonKey(name: 'BundleCount')
  int bundleCount;

  @JsonKey(name: 'TradeRemainCount')
  int tradeRemainCount;

  @JsonKey(name: 'YDayAvgPrice')
  int yDayAvgPrice;

  @JsonKey(name: 'RecentPrice')
  int recentPrice;

  @JsonKey(name: 'CurrentMinPrice')
  int currentMinPrice;

  factory SearchResultItems.fromJson(Map<String, dynamic> json) =>
      _$SearchResultItemsFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultItemsToJson(this);
}
