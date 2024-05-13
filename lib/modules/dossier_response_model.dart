import 'package:flutter_application/modules/dossier_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dossier_response_model.g.dart';

@JsonSerializable()
class DossierResponseModel {
  List<DossierModel> data;
  DossierResponseModel({required this.data});

  factory DossierResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DossierResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DossierResponseModelToJson(this);

  @override
  String toString() {
    var str = 'DossierResponseModel:\n';
    for (var item in data) {
      str += '${item.toString()} \n';
    }
    return str;
  }
}
