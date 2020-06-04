import 'package:kult/domain/contract/entity.dart';
import 'package:kult/domain/entities/choice_list.dart';

import '../contract/credentials.dart';
import '../contract/human.dart';
import '../contract/timestamps.dart';

import '../contract/Id.dart';

class Member extends Entity with Id, Credentials, Human, Timestamps {
  String phoneNumber;
  ChoiceList choice;
}
