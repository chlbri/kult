import 'package:kult/core/utils.dart';
import 'package:kult/domain/entities/program.dart';

import '../contracts/model.dart';
import '../contracts/updates.dart';
import '../contracts/update.dart';

class ProgramModel extends Program with Model, Updates<Program> {
  ProgramModel._(
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
      TypeChecker2(String, json["uid"]),
      TypeChecker2(DateTime, json["deletedAt"]),
    ]);
  }

  factory ProgramModel.fromJson(Map<String, dynamic> json,
      [bool withUpdates = false]) {
    if (!validateJson(json)) return null;
    final out = ProgramModel._(
      json['createdAt'],
      json['uid'],
      json['deletedAt'],
    );
    if (!withUpdates) return out;
    final updates = json['updates'];
    if (updates is! List<Map<String, dynamic>>) return out;
    final _updates = (updates as List<Map<String, dynamic>>)
        .map(
          (update) => Update<Program>.fromJson(
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
