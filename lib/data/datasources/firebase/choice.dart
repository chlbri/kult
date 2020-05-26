import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;
import 'package:flutter/foundation.dart';
import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/datasources/firebase/services/database.dart';
import 'package:kult/data/datasources/firebase/services/query_args.dart';
import 'package:kult/data/models/choice.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/domain/entities/member.dart';

const LIMIT = 158;

class ChoiceSource extends DataBaseService<ChoiceModel> {
  ChoiceSource([ChoiceModel model]) : super('Choice', model);

  static Future<String> get uid {
    return AuthService().currentUser.then(
          (value) => value.uid,
        );
  }

  Future<bool> create({ChoiceModel data, String uid}) async {
    if (isNullList([model, data])) {
      print("Cannot create model");
      return false;
    }

    final userUid = await ChoiceSource.uid;
    if (isNullList([uid, userUid])) {
      print("Cannot create");
      return false;
    }

    final json = (data ?? model).toJson();
    final choices = json['choices'] as List<int>;
    if(choices == null)  {
      print("Vous n'avez pas fait de choix");
      return false;
    }

    await hasReachedLimitChoice(choices);

    if(choices.isEmpty) {
      print("Vous n'avez plus le choix !");
      return false;
    }
    json['createdAt'] = DateTime.now();
    return collection
        .document(uid ?? userUid)
        .setData(json, merge: true)
        .then(
          (_) => true,
        )
        .catchError(
          (_) => false,
        );
  }

  Future hasReachedLimitChoice(List<int> choices, [int limit = LIMIT]) async {
    await Future.wait(choices.map(
      (e) => hasReachedLimit(
        limit,
        QueryArgs('choices', arrayContains: e),
      ).then((value) {
        if(value) choices.remove(e);
      }),
    ));
  }

  Future<bool> addOne(ChoiceList choice, String uid) async {
    print('Enter ...');
    print(uid);
    final docFuture = collection.document(uid).get();
    final exists = (await docFuture).data != null;
    final inModel = ChoiceModel([choice]);
    // try {
    return !exists
        ? this.create(data: inModel, uid: uid)
        : _addOne(choice, uid);
  }

  Future<bool> _addOne(ChoiceList choice, String uid) async {
    int _choice = choice.index;
    final _choices = [_choice];
    await hasReachedLimitChoice(_choices);

    if(_choices.isEmpty) {
      print("Vous n'avez plus le choix !");
      return false;
    }
    return collection.document(uid).get().then<bool>(
      (value) async {
        final ref = value.reference;
        final data = value.data;
        final check = data['choices'].contains(_choice);
        print(check);
        print(data);
        return check
            ? false
            : await ref
                .setData(
                  {
                    'choices': [...data['choices'], _choice]
                  },
                  merge: true,
                )
                .then<bool>((_) => true)
                .catchError((_) => false);
      },
    ).catchError((_) => false);
  }

  Future<bool> addOneAfter(MemberModel memberModel, ChoiceList choice) async {
    if (isNullAny([memberModel, choice])) return false;
    try {
      if (memberModel.uid == null) {
        return _addOneAfter(memberModel, choice);
      } else {
        return addOne(choice, memberModel.uid);
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> _addOneAfter(MemberModel memberModel, ChoiceList choice) {
    return MemberSource().collection.add(memberModel.toJson()).then<bool>(
      (memberSnap) {
        memberModel.uid = memberSnap.documentID;
        return collection.document(memberModel.uid).get().then(
          (choiceSnap) {
            return addOne(choice, memberModel.uid);
          },
        ).catchError((value) => false);
      },
    );
  }

  Future<bool> addOther(
      MemberModel memberModel, List<ChoiceList> choices) async {
    if (isNullAny([memberModel, choices])) return false;
    if (isNullAny([...choices])) return false;
    try {
      return MemberSource().collection.add(memberModel.toJson()).then<bool>(
        (memberSnap) {
          final memberUid = memberSnap.documentID;
          return collection.document(memberUid).get().then(
            (choiceSnap) {
              final choiceModel = ChoiceModel(choices);
              return create(
                data: choiceModel,
                uid: memberUid,
              );
            },
          ).catchError((value) => false);
        },
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeOther(
      MemberModel memberModel, List<ChoiceList> choices) async {
    if (isNullAny([memberModel, choices])) return false;
    if (isNullAny([...choices])) return false;
    try {
      return MemberSource().collection.add(memberModel.toJson()).then<bool>(
        (memberSnap) {
          final memberUid = memberSnap.documentID;
          return collection.document(memberUid).get().then(
            (choiceSnap) {
              return delete(
                memberUid,
              );
            },
          ).catchError((value) => false);
        },
      );
    } catch (e) {
      return false;
    }
  }

  // Future<bool> removeOneAfter(
  //     MemberModel memberModel, ChoiceList choice) async {
  //   if (isNullAny([memberModel, choice])) return false;
  //   try {
  //     return MemberSource().collection.add(memberModel.toJson()).then<bool>(
  //       (memberSnap) {
  //         final memberUid = memberSnap.documentID;
  //         return collection.document(memberUid).get().then(
  //           (choiceSnap) {
  //             return removeOne(choice, memberUid);
  //           },
  //         ).catchError((value) => false);
  //       },
  //     );
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<bool> removeOne(ChoiceList choice, String uid) async {
    int _choice = choice.index;
    try {
      return collection.document(uid).get().then(
        (value) async {
          final ref = value.reference;
          final data = value.data;

          if (!data['choices'].contains(_choice)) {
            return false;
          }
          return await ref.setData(
            {
              'choices': data['choices']..remove(_choice),
            },
            merge: true,
          ).then<bool>((_) {
            print('Removing one choice kult ...');
            return true;
          }).catchError((_) {
            print('Not Removing one choice kult ...');
            return false;
          });
        },
      ).catchError((_) => false);
    } catch (_) {
      return false;
    }
  }
}
