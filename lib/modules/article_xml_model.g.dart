// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_xml_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleXMLModel _$ArticleXMLModelFromJson(Map<String, dynamic> json) =>
    ArticleXMLModel(
      lineCount: (json['line_count'] as num).toInt(),
      charCount: (json['char_count'] as num).toInt(),
      snipText: json['snip_text'] as String? ?? '',
      fontSize: (json['font_size'] as num).toDouble(),
    );

Map<String, dynamic> _$ArticleXMLModelToJson(ArticleXMLModel instance) =>
    <String, dynamic>{
      'line_count': instance.lineCount,
      'char_count': instance.charCount,
      'snip_text': instance.snipText,
      'font_size': instance.fontSize,
    };
