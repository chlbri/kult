import 'package:kult/core/utils.dart';
import 'package:kult/domain/entities/division.dart';

import '../contracts/model.dart';
import '../contracts/updates.dart';
import '../contracts/update.dart';

class DivisionModel extends Division with Model, Updates<Division> {
  DivisionModel._(
    DateTime createdAt,
    String uid, [
    DateTime deletedAt,
  ]) {
    this.createdAt = createdAt;
    this.uid = uid;
    this.deletedAt = deletedAt;
  }

  static bool validateJson(dynamic json) {
    return checkTypes([
      TypeChecker2(DateTime, json["createdAt"]),
      TypeChecker2(String, json["id"]),
      TypeChecker2(DateTime, json["deletedAt"]),
    ]);
  }

  factory DivisionModel.fromJson(Map<String, dynamic> json,
      [bool withUpdates = false]) {
    if (!validateJson(json)) return null;
    final out = DivisionModel._(
      json['createdAt'],
      json['id'],
      json['deletedAt'],
    );
    if (!withUpdates) return out;
    final updates = json['updates'];
    if (updates is! List<Map<String, dynamic>>) return out;
    final _updates = (updates as List<Map<String, dynamic>>)
        .map(
          (update) => Update<Division>.fromJson(
            map: update,
            validator: validateJson,
          ),
        )
        .where((el) => el != null);
    if (_updates.isEmpty) return out;
    out.updates.addAll(_updates);
    return out;
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
