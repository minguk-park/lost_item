import 'package:json_annotation/json_annotation.dart';

part 'markets_categories_subs.g.dart';

@JsonSerializable()
class MarketsCategoriesSubs {
  MarketsCategoriesSubs(this.code, this.codeName);

  @JsonKey(name: 'Code')
  int code;

  @JsonKey(name: 'CodeName')
  String codeName;

  factory MarketsCategoriesSubs.fromJson(Map<String, dynamic> json) =>
      _$MarketsCategoriesSubsFromJson(json);
  Map<String, dynamic> toJson() => _$MarketsCategoriesSubsToJson(this);
}
