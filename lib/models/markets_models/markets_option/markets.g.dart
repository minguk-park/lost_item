// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Markets _$MarketsFromJson(Map<String, dynamic> json) => Markets(
      (json['Categories'] as List<dynamic>)
          .map((e) => MarketsCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['ItemGrades'] as List<dynamic>).map((e) => e as String).toList(),
      (json['ItemTiers'] as List<dynamic>).map((e) => e as int).toList(),
      (json['Classes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MarketsToJson(Markets instance) => <String, dynamic>{
      'Categories': instance.categories,
      'ItemGrades': instance.itemGrades,
      'ItemTiers': instance.itemTiers,
      'Classes': instance.classes,
    };
