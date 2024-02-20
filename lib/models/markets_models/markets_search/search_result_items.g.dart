// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultItems _$SearchResultItemsFromJson(Map<String, dynamic> json) =>
    SearchResultItems(
      json['Id'] as int,
      json['Name'] as String,
      json['Grade'] as String,
      json['Icon'] as String,
      json['BundleCount'] as int,
      json['TradeRemainCount'] as int?,
      (json['YDayAvgPrice'] as num).toDouble(),
      (json['RecentPrice'] as num).toDouble(),
      (json['CurrentMinPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$SearchResultItemsToJson(SearchResultItems instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Grade': instance.grade,
      'Icon': instance.icon,
      'BundleCount': instance.bundleCount,
      'TradeRemainCount': instance.tradeRemainCount,
      'YDayAvgPrice': instance.yDayAvgPrice,
      'RecentPrice': instance.recentPrice,
      'CurrentMinPrice': instance.currentMinPrice,
    };
