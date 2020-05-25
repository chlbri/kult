import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;
import 'package:kult/data/datasources/contracts/model.dart';
import 'package:kult/data/datasources/contracts/update.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/datasources/firebase/services/database.dart';
import 'package:kult/data/models/choice.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/choice.dart';

class ChoiceSource extends DataBaseService<ChoiceModel> {
  ChoiceSource(ChoiceModel model) : super('Choice', model);

  static Future<FirebaseUser> get user => AuthService().currentUser;

  Future<bool> create() async {
    final json = model.toJson();
    json['createdAt'] = DateTime.now();
    return collection
        .document((await user).uid)
        .setData(json, merge: true)
        .then(
          (_) => true,
        )
        .catchError(
          (_) => false,
        );
  }

  updates() async {
    final json = model.toJson();
    collection.document((await user).uid).get().then((value) {
      final ref = value.reference;
      final temp = value.data;
      if (model.choice.index != temp['choice']) {
        print(temp);
        ref.collection('updates').getDocuments().then(
              (value) => print(value.documents.length),
            );
        // print(c['choice']);
        final up = <String, dynamic>{
          'choice': model.choice.index,
        };
        if (temp['createdAt'] == null) {
          up['createdAt'] = DateTime.now();
        }
        ref
            .setData({
              'choice': model.choice.index,
            }, merge: true)
            .then((value) => true)
            .catchError((_) => false);
        ref
            .collection('updates')
            .add(
              {
                'date': DateTime.now(),
                'before': temp..remove('updates')..remove('createdAt'),
                'after': json,
              },
            )
            .then((_) => true)
            .catchError((_) => false);
      }
    });

    // collection.document((await user).uid).setData({
    //   'updates': [
    //     {
    //       'date': DateTime.now(),
    //       'before': c..remove('updates')..remove('createdAt'),
    //       'after': json..remove('updates'),
    //     }
    //   ]
    // }, merge: true);
  }
}
