// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Markets _$MarketsFromJson(Map<String, dynamic> json) => Markets(
      (json['categories'] as List<dynamic>?)
          ?.map((e) => MarketsCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['itemGrades'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['itemTiers'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['classes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MarketsToJson(Markets instance) => <String, dynamic>{
      'categories': instance.categories,
      'itemGrades': instance.itemGrades,
      'itemTiers': instance.itemTiers,
      'classes': instance.classes,
    };
