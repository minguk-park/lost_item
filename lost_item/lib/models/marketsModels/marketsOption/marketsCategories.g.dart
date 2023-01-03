// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketsCategories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketsCategories _$MarketsCategoriesFromJson(Map<String, dynamic> json) =>
    MarketsCategories(
      (json['subs'] as List<dynamic>?)
          ?.map(
              (e) => MarketsCategoriesSubs.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['code'] as int?,
      json['codeName'] as String?,
    );

Map<String, dynamic> _$MarketsCategoriesToJson(MarketsCategories instance) =>
    <String, dynamic>{
      'subs': instance.subs,
      'code': instance.code,
      'codeName': instance.codeName,
    };
