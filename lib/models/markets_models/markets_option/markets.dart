import 'package:json_annotation/json_annotation.dart';

import 'markets_categories.dart';

part 'markets.g.dart';

@JsonSerializable()
class Markets {
  Markets(this.categories, this.itemGrades, this.itemTiers, this.classes);

  @JsonKey(name: 'Categories')
  List<MarketsCategories> categories;

  @JsonKey(name: 'ItemGrades')
  List<String> itemGrades;

  @JsonKey(name: 'ItemTiers')
  List<int> itemTiers;

  @JsonKey(name: 'Classes')
  List<String> classes;

  factory Markets.fromJson(Map<String, dynamic> json) =>
      _$MarketsFromJson(json);
  Map<String, dynamic> toJson() => _$MarketsToJson(this);
}
