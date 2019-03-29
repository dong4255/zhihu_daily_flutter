import 'package:json_annotation/json_annotation.dart';

import 'story.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  String date;
  List<Story> stories;
  List<Story> top_stories;

  News({this.date, this.stories, this.top_stories});

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}