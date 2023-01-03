import 'package:json_annotation/json_annotation.dart';

part 'marketsCategoriesSubs.g.dart';

@JsonSerializable()
class MarketsCategoriesSubs {
  MarketsCategoriesSubs(this.code, this.codeName);

  int? code;
  String? codeName;

  factory MarketsCategoriesSubs.fromJson(Map<String, dynamic> json) =>
      _$MarketsCategoriesSubsFromJson(json);
  Map<String, dynamic> toJson() => _$MarketsCategoriesSubsToJson(this);
}
