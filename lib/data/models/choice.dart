import 'package:kult/core/utils.dart';

import '../contracts/model.dart';
import '../contracts/updates.dart';
import '../contracts/update.dart';
import 'package:kult/domain/entities/choice.dart';
import 'package:kult/domain/entities/choice_list.dart';

class ChoiceModel extends Choice with Model, Updates<Choice> {
  ChoiceModel(ChoiceList choice, [String uid]) {
    this.choice = choice;
    this.uid = uid;
  }

  ChoiceModel.fromEntity(Choice data) : this(data?.choice);

  static bool validateJson(dynamic json) {
    return checkTypes([
      FunctionChecker<List<int>>(
        (values) => values.every(
          (value) => 0 <= value && value < ChoiceList.values.length,
        ),
        json["choice"],
      ),
      TypeChecker2(DateTime, json["createdAt"]),
      TypeChecker2(String, json["id"]),
    ]);
  }

  factory ChoiceModel.fromJson(Map<String, dynamic> json,
      [bool withUpdates = false]) {
    // print(json);
    // print(json['choice'].runtimeType);
    // if (!validateJson(json)) return null;

    final out = ChoiceModel(
      json['choice'],
      json['id'],
    );
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
    final out = <String, dynamic>{};
    out.put('choice', choice.index);
    print(out);
    if (!withUpdates) return out;
    out['updates'] = updates;
    return out;
  }
}
