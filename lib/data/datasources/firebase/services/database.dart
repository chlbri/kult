import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kult/data/datasources/firebase/services/query_args.dart';
import '../../contracts/model.dart';

abstract class DataBaseService<T extends Model> {
  final database = Firestore.instance;
  final String colName;
  final T model;

  static const Collections = ["Members", ""];

  DataBaseService(this.colName, this.model);

  CollectionReference get collection => database.collection(colName);

  Future<bool> create() async {
    final json = model.toJson();
    return collection.add(json..remove("mdp")..remove("uid")).then(
      (val) {
        print('Creating...');
        model.uid = val.documentID;

        return true;
      },
    ).catchError(
      (e) {
        print('Rejecting...');
        return false;
      },
    );
  }

  Future<bool> hasReachedLimit(int limit, [QueryArgs args]) async {
    return (args == null
            ? collection
            : collection.where(
                args.field,
                isEqualTo: args.isEqualTo,
                isLessThan: args.isLessThan,
                isLessThanOrEqualTo: args.isLessThanOrEqualTo,
                isGreaterThan: args.isGreaterThan,
                isGreaterThanOrEqualTo: args.isGreaterThanOrEqualTo,
                arrayContains: args.arrayContains,
                arrayContainsAny: args.arrayContainsAny,
                whereIn: args.whereIn,
                isNull: args.isNull,
              ))
        .getDocuments()
        .then(
          (value) {
            print(value.documents.length);
            return value.documents.length >= limit;
          },
        );
  }

  Future<Map<String, dynamic>> read(String uid) {
    return collection
        .document(uid)
        .get()
        .then(
          (value) => value.data,
        )
        .catchError(
          (_) => null,
        );
  }

  Future<bool> update(String uid) {
    final json = model.toJson();
    return collection
        .document(uid)
        .setData(json, merge: true)
        .then(
          (_) => true,
        )
        .catchError(
          (_) => false,
        );
  }

  Future<bool> delete([String uid]) {
    return collection
        .document(
          uid ?? model.uid,
        )
        .delete()
        .then((_) => true)
        .catchError((_) => false);
  }
}
