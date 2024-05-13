// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dossier_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DossierResponseModel _$DossierResponseModelFromJson(
        Map<String, dynamic> json) =>
    DossierResponseModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => DossierModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DossierResponseModelToJson(
        DossierResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
