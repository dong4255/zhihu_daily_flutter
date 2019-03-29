// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDetail _$NewsDetailFromJson(Map<String, dynamic> json) {
  return NewsDetail(
      body: json['body'] as String,
      image_source: json['image_source'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      share_url: json['share_url'] as String,
      js: (json['js'] as List)?.map((e) => e as String)?.toList(),
      ga_prefix: json['ga_prefix'] as String,
      type: json['type'] as int,
      id: json['id'] as int,
      css: (json['css'] as List)?.map((e) => e as String)?.toList(),
      recommenders: (json['recommenders'] as List)
          ?.map((e) => e == null
              ? null
              : Recommender.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      section: json['section'] == null
          ? null
          : Section.fromJson(json['section'] as Map<String, dynamic>));
}

Map<String, dynamic> _$NewsDetailToJson(NewsDetail instance) =>
    <String, dynamic>{
      'body': instance.body,
      'image_source': instance.image_source,
      'title': instance.title,
      'image': instance.image,
      'share_url': instance.share_url,
      'js': instance.js,
      'ga_prefix': instance.ga_prefix,
      'type': instance.type,
      'id': instance.id,
      'css': instance.css,
      'recommenders': instance.recommenders,
      'section': instance.section
    };

Recommender _$RecommenderFromJson(Map<String, dynamic> json) {
  return Recommender(avatar: json['avatar'] as String);
}

Map<String, dynamic> _$RecommenderToJson(Recommender instance) =>
    <String, dynamic>{'avatar': instance.avatar};

Section _$SectionFromJson(Map<String, dynamic> json) {
  return Section(
      thumbnail: json['thumbnail'] as String,
      id: json['id'] as int,
      name: json['name'] as String);
}

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'id': instance.id,
      'name': instance.name
    };
