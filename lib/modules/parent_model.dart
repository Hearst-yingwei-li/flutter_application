import 'package:flutter_application/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
part 'parent_model.g.dart';

@JsonSerializable()
class ParentModel {
  final int parentId;
  @JsonKey(name: 'p_minorversion')
  final int pMinorversion;
  @JsonKey(name: 'sor_pagerange')
  final String sorPagerange;
  @JsonKey(fromJson: Utils.decodeUrl, name: 'p_storename')
  final String pStorename;

  ParentModel({
    required this.parentId,
    required this.pMinorversion,
    required this.sorPagerange,
    required this.pStorename,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) =>
      _$ParentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParentModelToJson(this);

  @override
  String toString() {
    return 'ParentModel: {parentId: $parentId, pMinorversion: $pMinorversion, sorPagerange: $sorPagerange, pStorename:$pStorename';
  }

  @override
  bool operator ==(Object other) {
    // Type check for 'other' being exactly an instance of 'Person'
    if (identical(this, other)) return true;
    return other is ParentModel &&
        other.parentId == parentId &&
        other.pMinorversion == pMinorversion &&
        other.sorPagerange == sorPagerange;
  }

  @override
  int get hashCode => Object.hash(parentId, pMinorversion, sorPagerange);
}
