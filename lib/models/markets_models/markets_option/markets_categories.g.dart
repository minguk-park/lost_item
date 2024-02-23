// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markets_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketsCategories _$MarketsCategoriesFromJson(Map<String, dynamic> json) =>
    MarketsCategories(
      (json['Subs'] as List<dynamic>)
          .map((e) => MarketsCategoriesSubs.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Code'] as int,
      json['CodeName'] as String,
    );

Map<String, dynamic> _$MarketsCategoriesToJson(MarketsCategories instance) =>
    <String, dynamic>{
      'Subs': instance.subs,
      'Code': instance.code,
      'CodeName': instance.codeName,
    };
