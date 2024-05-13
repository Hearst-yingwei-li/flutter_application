import 'package:flutter_application/modules/article_xml_model.dart';
import 'package:flutter_application/modules/parent_model.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
part 'content_model.g.dart';

@JsonSerializable()
class ContentModel {
  final int id;
  final int minorversion;
  final String name;
  @JsonKey(fromJson: Utils.decodeUrl)
  final String storename;
  final String type;
  final ParentModel parent;
  @JsonKey(name: 'article_plaintexts')
  final List<String>? articlePlaintexts;

  ContentModel({
    required this.id,
    required this.name,
    required this.minorversion,
    required this.storename,
    required this.type,
    required this.parent,
    this.articlePlaintexts,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) =>
      _$ContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentModelToJson(this);

  @override
  String toString() {
    return 'ContentModel: {id: $id, name: $name, type: $type, storename:$storename, minorversion:$minorversion  articles:$articlePlaintexts}';
  }
}
