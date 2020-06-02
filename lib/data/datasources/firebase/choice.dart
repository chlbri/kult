import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/datasources/firebase/services/database.dart';
import 'package:kult/data/models/choice.dart';
import 'package:kult/domain/entities/choice.dart';

const LIMIT = 148;

class FireStoreChoiceSource extends FireStoreService<ChoiceModel> {
  FireStoreChoiceSource([ChoiceModel model]) : super('Member', model);

  static Future<String> get getUserUid {
    return FirebaseAuthService().currentUser.then(
          (value) => value.uid,
        );
  }

  Future<Choice> read(String uid) async {
    return collection.document(uid ?? await getUserUid).get().then(
      (value) {
        final data = ChoiceModel.fromJson(value?.data);
        return data;
      },
    ).catchError(
      (_) => null,
    );
  }

  Future<bool> update(ChoiceModel data,{String uid}) async {
    final innerUid = data.uid ?? await getUserUid;
    if (isNull(innerUid)) {
      print("Cannot create");
      return false;
    }
    final json = data.toJson();
    return collection
        .document(innerUid)
        .setData(json, merge: true)
        .then(
          (_) => true,
        )
        .catchError(
          (_) => false,
        );
  }

  Future<bool> delete(String uid) async {
    return collection
        .document(
          uid ?? await getUserUid,
        )
        .setData({'choice': FieldValue.delete()})
        .then((_) => true)
        .catchError((_) => false);
  }
}
