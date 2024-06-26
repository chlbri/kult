import 'package:kult/core/utils.dart';
import 'package:kult/domain/entities/preacher.dart';

import '../contracts/model.dart';
import '../contracts/updates.dart';
import '../contracts/update.dart';

class PreacherModel extends Preacher with Model, Updates<Preacher> {
  PreacherModel._([
    String uid,
    String login,
    String mdp,
    String firstNames,
    String lastName,
    DateTime createdAt,
    DateTime deletedAt,
  ]) {
    this.uid = uid;
    this.createdAt = createdAt;
    this.deletedAt = deletedAt;
    this.login = login;
    this.mdp = mdp;
    this.firstNames = firstNames;
    this.lastName = lastName;
  }

  static bool validateJson(dynamic json) {
    return checkTypes([
      TypeChecker2(DateTime, json["createdAt"]),
      TypeChecker2(String, json["uid"]),
      TypeChecker2(String, json["login"]),
      TypeChecker2(String, json["mdp"]),
      TypeChecker2(String, json["firstNames"]),
      TypeChecker2(String, json["lastName"]),
      TypeChecker2(DateTime, json["deletedAt"]),
    ]);
  }

  factory PreacherModel.fromJson(Map<String, dynamic> json,
      [bool withUpdates = false]) {
    if (!validateJson(json)) return null;
    final out = PreacherModel._(
      json["createdAt"],
      json["uid"],
      json["login"],
      json["mdp"],
      json["firstNames"],
      json["lastName"],
      json["deletedAt"],
    );
    if (!withUpdates) return out;
    final updates = json['updates'];
    if (updates is! List<Map<String, dynamic>>) return out;
    final _updates = (updates as List<Map<String, dynamic>>)
        .map(
          (update) => Update<Preacher>.fromJson(
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
