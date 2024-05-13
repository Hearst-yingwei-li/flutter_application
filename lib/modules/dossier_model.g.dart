// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dossier_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DossierModel _$DossierModelFromJson(Map<String, dynamic> json) => DossierModel(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      name: json['name'] as String,
      pagerange: json['pagerange'] as String,
      childs: (json['childs'] as List<dynamic>)
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      titles: (json['titles'] as List<dynamic>?)
          ?.map((e) => ArticleXMLModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadings: (json['leadings'] as List<dynamic>?)
          ?.map((e) => ArticleXMLModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DossierModelToJson(DossierModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'pagerange': instance.pagerange,
      'childs': instance.childs,
      'titles': instance.titles,
      'leadings': instance.leadings,
    };
