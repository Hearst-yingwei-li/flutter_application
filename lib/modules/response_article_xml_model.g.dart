// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_article_xml_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseArticleXMLModel _$ResponseArticleXMLModelFromJson(
        Map<String, dynamic> json) =>
    ResponseArticleXMLModel(
      articleXMLs: (json['article_xmls'] as List<dynamic>)
          .map((e) => ArticleXMLModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseArticleXMLModelToJson(
        ResponseArticleXMLModel instance) =>
    <String, dynamic>{
      'article_xmls': instance.articleXMLs,
    };
