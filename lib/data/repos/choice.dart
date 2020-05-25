import 'package:kult/core/utils.dart';

import '../datasources/contracts/model.dart';
import '../datasources/contracts/updates.dart';
import '../datasources/contracts/update.dart';
import 'package:kult/domain/entities/choice.dart';
import 'package:kult/domain/entities/choice_list.dart';

class ChoiceModel extends Choice with Model, Updates<Choice> {
  ChoiceModel._(ChoiceList choice, String id) {
    this.choice = choice;
    this.id = id;
  }

  static bool validateJson(dynamic json) {
    return checkTypes([
      FunctionChecker<int>(
        (value) => 0 <= value && value < ChoiceList.values.length,
        json["createdAt"],
      ),
      TypeChecker2(String, json["id"]),
    ]);
  }

  factory ChoiceModel.fromJson(Map<String, dynamic> json,
      [bool withUpdates = false]) {
    if (!validateJson(json)) return null;
    final out = ChoiceModel._(ChoiceList.values[json['choice']], json['id']);
    if (!withUpdates) return out;
    final updates = json['updates'];
    if (updates is! List<Map<String, dynamic>>) return out;
    final _updates = (updates as List<Map<String, dynamic>>)
        .map(
          (update) => Update<Choice>.fromJson(
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
    const out = <String, dynamic>{};
    out["id"] = id;
    out["choice"] = choice.index;
    if (!withUpdates) return out;
    out['updates'] = updates;
    return out;
  }
}

class ChoiceRepo{
  
}
