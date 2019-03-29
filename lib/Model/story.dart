import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  String title;
  List<String> images;
  String ga_prefix;
  bool multipic;
  int type;
  int id;
  String image;

  Story({this.title, this.images, this.ga_prefix, this.multipic, this.type, this.id, this.image});

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoryToJson(this);

}