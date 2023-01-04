import 'package:json_annotation/json_annotation.dart';

import 'marketsCategoriesSubs.dart';

part 'marketsCategories.g.dart';

@JsonSerializable()
class MarketsCategories {
  MarketsCategories(this.subs, this.code, this.codeName);

  @JsonKey(name: 'Subs')
  List<MarketsCategoriesSubs>? subs;

  @JsonKey(name: 'Code')
  int? code;

  @JsonKey(name: 'CodeName')
  String? codeName;

  factory MarketsCategories.fromJson(Map<String, dynamic> json) =>
      _$MarketsCategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$MarketsCategoriesToJson(this);
}
