// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentModel _$ContentModelFromJson(Map<String, dynamic> json) => ContentModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      minorversion: (json['minorversion'] as num).toInt(),
      storename: Utils.decodeUrl(json['storename'] as String),
      type: json['type'] as String,
      parent: ParentModel.fromJson(json['parent'] as Map<String, dynamic>),
      articlePlaintexts: (json['article_plaintexts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ContentModelToJson(ContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'minorversion': instance.minorversion,
      'name': instance.name,
      'storename': instance.storename,
      'type': instance.type,
      'parent': instance.parent,
      'article_plaintexts': instance.articlePlaintexts,
    };
