import 'package:json_annotation/json_annotation.dart';
part 'dropdown_model.g.dart';

@JsonSerializable()
class DropdownModel {
  final int id;
  final String? name;
  final String? type;
  DropdownModel({required this.id, this.name, this.type});
  factory DropdownModel.fromJson(Map<String, dynamic> json) =>
      _$DropdownModelFromJson(json);

  Map<String, dynamic> toJson() => _$DropdownModelToJson(this);

  @override
  String toString() {
    return 'DropdownModel: {id: $id, name: $name, type: $type}';
  }
}
