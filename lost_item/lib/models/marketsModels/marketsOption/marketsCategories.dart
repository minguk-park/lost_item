import 'package:json_annotation/json_annotation.dart';

import 'marketsCategoriesSubs.dart';

part 'marketsCategories.g.dart';

@JsonSerializable()
class MarketsCategories {
  MarketsCategories(this.subs, this.code, this.codeName);

  List<MarketsCategoriesSubs>? subs;
  int? code;
  String? codeName;

  factory MarketsCategories.fromJson(Map<String, dynamic> json) =>
      _$MarketsCategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$MarketsCategoriesToJson(this);
}
