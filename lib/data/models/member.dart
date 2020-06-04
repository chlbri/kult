import 'package:kult/core/utils.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/domain/entities/member.dart';

import '../contracts/model.dart';
import '../contracts/updates.dart';
import '../contracts/update.dart';

class MemberModel extends Member with Model, Updates<Member> {
  MemberModel(
      {String uid,
      String login,
      String mdp,
      String firstNames,
      String lastName,
      String phoneNumber,
      DateTime createdAt,
      DateTime deletedAt,
      ChoiceList
          choice}) /* : assert(
          !isNullAny([
            firstNames,
            lastName,
            login,
            phoneNumber,
          ]),
        ) */
  {
    this.uid = uid;
    this.createdAt = createdAt;
    this.deletedAt = deletedAt;
    this.login = login;
    this.mdp = mdp;
    this.firstNames = firstNames;
    this.lastName = lastName;
    this.phoneNumber = phoneNumber;
    this.choice = choice;
  }

  MemberModel.fromEntity(Member data)
      : this(
          firstNames: data.firstNames,
          lastName: data.lastName,
          login: data.login,
          phoneNumber: data.phoneNumber,
          choice: data.choice,
          uid: data.uid,
        );

  static bool validateJson(dynamic json) {
    return checkTypes([
      TypeChecker2(DateTime, json["createdAt"]),
      TypeChecker2(String, json["uid"]),
      TypeChecker2(String, json["login"]),
      TypeChecker2(String, json["mdp"]),
      TypeChecker2(String, json["choice"]),
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
    return MemberModel(
      login: json["login"],
      phoneNumber: json["phoneNumber"],
      firstNames: json["firstNames"],
      lastName: json["lastName"],
      choice: (json['choice'] as int) == null
          ? null
          : ChoiceList.values[json['choice'] as int],
    );
    final out = MemberModel(
      login: json["login"],
      phoneNumber: json["phoneNumber"],
      firstNames: json["firstNames"],
      lastName: json["lastName"],
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
    out.put('uid', uid);
    out.put('login', login);
    out.put('choice', choice.index);
    out.put('phoneNumber', phoneNumber);
    out.put('firstNames', firstNames);
    out.put('lastName', lastName);
    out.put('createdAt', createdAt);
    if (!withUpdates) return out;
    return out;
  }
}
