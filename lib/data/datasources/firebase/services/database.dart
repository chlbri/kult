import 'package:cloud_firestore/cloud_firestore.dart';
import '../../contracts/model.dart';
import '../../contracts/crud.dart';

class DataBaseService<T extends Model> {
  final _database = Firestore.instance;
  final String colName;
  final T model;

  static const Collections = ["Members", ""];

  DataBaseService(this.colName, this.model);

  CollectionReference get collection => _database.collection(colName);

  Future<bool> create() async {
    final json = model.toJson();
    return collection
        .add(json..remove("mdp")..remove("uid"))
        .then(
          (val) {
            print('Creating...');
            return true;
          },
        )
        .catchError(
          (e) {
            print('Rejecting...');
            return false;
          },
        );
  }

  // @override
  // read(T arg) {
  //   // TODO: implement delete
  //   throw UnimplementedError();
  // }

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

  // @override
  // delete(T arg) {
  //   // TODO: implement update
  //   throw UnimplementedError();
  // }
}
