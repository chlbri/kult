import 'package:kult/ebr/entities/choice_list.dart';
import 'package:kult/ebr/entities/contract/Id.dart';
import 'package:kult/ebr/entities/contract/updates.dart';

class Choice with Id, Updates<Choice> {
  ChoiceList choice;
}
