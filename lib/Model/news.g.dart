// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
      date: json['date'] as String,
      stories: (json['stories'] as List)
          ?.map((e) =>
              e == null ? null : Story.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      top_stories: (json['top_stories'] as List)
          ?.map((e) =>
              e == null ? null : Story.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'date': instance.date,
      'stories': instance.stories,
      'top_stories': instance.top_stories
    };
