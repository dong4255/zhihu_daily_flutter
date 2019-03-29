// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
      title: json['title'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      ga_prefix: json['ga_prefix'] as String,
      multipic: json['multipic'] as bool,
      type: json['type'] as int,
      id: json['id'] as int,
      image: json['image'] as String);
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'title': instance.title,
      'images': instance.images,
      'ga_prefix': instance.ga_prefix,
      'multipic': instance.multipic,
      'type': instance.type,
      'id': instance.id,
      'image': instance.image
    };
