import 'package:json_annotation/json_annotation.dart';
part 'article_xml_model.g.dart';

@JsonSerializable()
class ArticleXMLModel {
  @JsonKey(name: 'line_count')
  final int lineCount;
  @JsonKey(name: 'char_count')
  final int charCount;
  @JsonKey(name: 'snip_text', defaultValue: '')
  final String snipText;
  @JsonKey(name: 'font_size')
  final double fontSize;

  ArticleXMLModel({
    required this.lineCount,
    required this.charCount,
    required this.snipText,
    required this.fontSize,
  });

  factory ArticleXMLModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleXMLModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleXMLModelToJson(this);

  @override
  String toString() {
    return 'ArticleXMLModel: {lineCount: $lineCount, charCount: $charCount, snipText: $snipText, fontSize:$fontSize}';
  }
}
