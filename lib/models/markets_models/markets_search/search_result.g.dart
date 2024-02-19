// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      json['PageNo'] as int?,
      json['PageSize'] as int?,
      json['TotalCount'] as int?,
      (json['Items'] as List<dynamic>?)
          ?.map((e) => SearchResultItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'PageNo': instance.pageNo,
      'PageSize': instance.pageSize,
      'TotalCount': instance.totalCount,
      'Items': instance.items,
    };
