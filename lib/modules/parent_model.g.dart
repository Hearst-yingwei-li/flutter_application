// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentModel _$ParentModelFromJson(Map<String, dynamic> json) => ParentModel(
      parentId: (json['parentId'] as num).toInt(),
      pMinorversion: (json['p_minorversion'] as num).toInt(),
      sorPagerange: json['sor_pagerange'] as String,
      pStorename: Utils.decodeUrl(json['p_storename'] as String),
    );

Map<String, dynamic> _$ParentModelToJson(ParentModel instance) =>
    <String, dynamic>{
      'parentId': instance.parentId,
      'p_minorversion': instance.pMinorversion,
      'sor_pagerange': instance.sorPagerange,
      'p_storename': instance.pStorename,
    };
