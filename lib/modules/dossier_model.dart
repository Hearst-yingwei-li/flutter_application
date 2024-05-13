import 'package:flutter_application/modules/article_xml_model.dart';
import 'package:flutter_application/modules/content_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dossier_model.g.dart';

@JsonSerializable()
class DossierModel {
  int id;
  String type;
  String name;
  String pagerange;
  List<ContentModel> childs;
  List<ArticleXMLModel>? titles;
  List<ArticleXMLModel>? leadings;

  DossierModel({
    required this.id,
    required this.type,
    required this.name,
    required this.pagerange,
    required this.childs,
    this.titles,
    this.leadings,
  });

  factory DossierModel.fromJson(Map<String, dynamic> json) =>
      _$DossierModelFromJson(json);

  Map<String, dynamic> toJson() => _$DossierModelToJson(this);

  @override
  String toString() {
    return 'DropdownModel: {id: ${id.toString()} type: $type name: $name pagerange: $pagerange childs: $childs  titles:$titles  leadings:$leadings}';
  }

  // static _decodeUrl(String storename) {
  //   return Uri.encodeComponent(storename).replaceAll(' ', '+');
  // }
}
