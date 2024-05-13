import 'package:flutter_application/modules/article_xml_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_article_xml_model.g.dart';

@JsonSerializable()
class ResponseArticleXMLModel {
  @JsonKey(name: 'article_xmls')
  final List<ArticleXMLModel> articleXMLs;
  ResponseArticleXMLModel({required this.articleXMLs});

  factory ResponseArticleXMLModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseArticleXMLModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseArticleXMLModelToJson(this);

  @override
  String toString() {
    var str = 'ResponseArticleXMLModel:\n';
    for (var item in articleXMLs) {
      str += '${item.toString()} \n';
    }
    return str;
  }
}
