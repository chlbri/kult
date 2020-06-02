import 'package:kult/core/utils.dart';
import 'package:kult/domain/entities/member.dart';

import '../contracts/model.dart';
import '../contracts/updates.dart';
import '../contracts/update.dart';

class MemberModel extends Member with Model, Updates<Member> {
  MemberModel({
    String id,
    String login,
    String mdp,
    String firstNames,
    String lastName,
    String phoneNumber,
    DateTime createdAt,
    DateTime deletedAt,
  }) /* : assert(
          !isNullAny([
            firstNames,
            lastName,
            login,
            phoneNumber,
          ]),
        ) */
  {
    this.id = id;
    this.createdAt = createdAt;
    this.deletedAt = deletedAt;
    this.login = login;
    this.mdp = mdp;
    this.firstNames = firstNames;
    this.lastName = lastName;
    this.phoneNumber = phoneNumber;
  }

  MemberModel.fromEntity(Member data)
      : this(
          firstNames: data.firstNames,
          lastName: data.lastName,
          login: data.login,
          phoneNumber: data.phoneNumber,
        );

  static bool validateJson(dynamic json) {
    return checkTypes([
      TypeChecker2(DateTime, json["createdAt"]),
      TypeChecker2(String, json["id"]),
      TypeChecker2(String, json["login"]),
      TypeChecker2(String, json["mdp"]),
      TypeChecker2(int, json["phoneNumber"]),
      TypeChecker2(String, json["firstNames"]),
      TypeChecker2(String, json["lastName"]),
      TypeChecker2(DateTime, json["deletedAt"]),
    ]);
  }

  factory MemberModel.fromJson(
    Map<String, dynamic> json, [
    bool withUpdates = false,
  ]) {
    // if (!validateJson(json)) return null;
    print('fromJson...');
    print(json);
    final out = MemberModel(
      createdAt: json["createdAt"],
      id: json["id"],
      login: json["login"],
      mdp: json["mdp"],
      phoneNumber: json["phoneNumber"],
      firstNames: json["firstNames"],
      lastName: json["lastName"],
      deletedAt: json["deletedAt"],
    );
    if (!withUpdates) return out;
    final updates = json['updates'];
    if (updates is! List<Map<String, dynamic>>) return out;
    final _updates = (updates as List<Map<String, dynamic>>)
        .map(
          (update) => Update<Member>.fromJson(
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
  Map<String, dynamic> toJson([bool withUpdates = false]) {
    final out = <String, dynamic>{};
    out.put('createdAt', createdAt ??= DateTime.now());
    out.put('uid', id);
    out.put('login', login);
    out.put('phoneNumber', phoneNumber);
    out.put('firstNames', firstNames);
    out.put('lastName', lastName);
    out.put('createdAt', createdAt);
    if (!withUpdates) return out;
    return out;
  }
}
