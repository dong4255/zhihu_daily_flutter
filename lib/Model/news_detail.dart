import 'package:json_annotation/json_annotation.dart';

part 'news_detail.g.dart';

@JsonSerializable()

class NewsDetail {
  String body;
  String image_source;
  String title;
  String image;
  String share_url;
  List<String> js;
  String ga_prefix;
  int type;
  int id;
  List<String> css;
  List<Recommender> recommenders;
  Section section;

  NewsDetail({this.body, this.image_source, this.title, this.image, this.share_url, this.js, this.ga_prefix, this.type, this.id, this.css, this.recommenders, this.section});

  factory NewsDetail.fromJson(Map<String, dynamic> json) => _$NewsDetailFromJson(json);
  Map<String, dynamic> toJson() => _$NewsDetailToJson(this);

}

@JsonSerializable()
class Recommender {
  String avatar;

  Recommender({this.avatar});

  factory Recommender.fromJson(Map<String, dynamic> json) => _$RecommenderFromJson(json);
  Map<String, dynamic> toJson() => _$RecommenderToJson(this);
}

@JsonSerializable()
class Section {
  String thumbnail;
  int id;
  String name;

  Section({this.thumbnail, this.id, this.name});

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
  Map<String, dynamic> toJson() => _$SectionToJson(this);

}