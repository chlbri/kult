import 'package:equatable/equatable.dart';

import 'package:kult/domain/contract/entity.dart';
import 'package:kult/domain/entities/choice_list.dart';

import '../contract/Id.dart';
import '../contract/credentials.dart';
import '../contract/human.dart';
import '../contract/timestamps.dart';
import '../contract/admin.dart';

class Member extends Entity
    with Id, Credentials, Human, Timestamps, Admin, EquatableMixin {
  String phoneNumber;
  ChoiceList choice;

  @override
  get props => [firstNames, lastName, login, phoneNumber, choice];

  // Mapget fields => {
  //       'uid': uid,
  //       'createdAt': createdAt,
  //       'deletedAt': deletedAt,
  //       'login': login,
  //       'firstNames': firstNames,
  //       'lastName': lastName,
  //       'phoneNumber': phoneNumber,
  //       'choice': choice,
  //     };
}
