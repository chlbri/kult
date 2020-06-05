import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/datasources/firebase/services/database.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/member.dart';

class ResultMemberMany {
  final String last;
  final Iterable<MemberModel> datas;

  ResultMemberMany(this.last, this.datas);
}

class FirestoreMemberSource extends FireStoreService<MemberModel> {
  MemberModel member;
  final _auth = FirebaseAuthService();

  FirestoreMemberSource([this.member]) : super("Member", member);

  static Future<String> get getUserUid {
    return FirebaseAuthService().currentUser.then(
          (value) => value.uid,
        );
  }

  Future<bool> signIn() {
    return _auth.signInWithEmailAndPassword(
      member.login,
      member.mdp,
    );
  }

  Future<Member> read(String uid) async {
    final snap = await collection.document(uid).get();
    return MemberModel.fromJson(
      snap.data,
    );
  }

  Future<String> update(MemberModel data) async {
    final uid = data.uid;
    final json = data.toJson();
    assert(!isNullString(uid));
    return await collection
        .document(uid)
        .setData(json..remove("mdp")..remove("uid"), merge: true)
        .then((value) => uid);
  }

  Future<List<MemberModel>> readAll(MemberModel data) async {
    return await queryMany(data).getDocuments().then(
          (value) => value.documents
              .map(
                (e) => MemberModel.fromJson(e.data..['uid'] = e.documentID),
              )
              .toList(),
        );
  }

  Query queryMany(MemberModel data) {
    Query query = collection;
    final _data = data.toJson()..remove('createdAt');
    _data.removeWhere(
      (key, value) =>
          key == 'uid' || value == null || value is String && value.isEmpty,
    );
    _data.forEach((key, value) {
      query = query.where(key, isEqualTo: value);
    });
    return query;
  }

  Future<ResultMemberMany> readMore(
    MemberModel data, {
    int limit,
    String uid,
  }) async {
    return await (uid == null
            ? queryMany(data)
            : queryMany(data).orderBy(FieldPath.documentId).startAfter([uid]))
        .limit(limit)
        .getDocuments()
        .then(
      (value) {
        final docs = value.documents;
        final last = docs.last.documentID;
        final list = value.documents.map(
          (e) => MemberModel.fromJson(e.data..['uid'] = e.documentID),
        );
        return ResultMemberMany(last, list);
      },
    );
  }

  Future<String> create(MemberModel data) async {
    final json = data.toJson();
    return collection
        .add(
      json..remove("mdp")..remove("uid"),
    )
        .then(
      (val) {
        print('Creating...');
        data.uid = val.documentID;
        print(data.uid);
        return val.documentID;
      },
    ).catchError(
      (e) {
        print('Rejecting...');
        return null;
      },
    );
  }

  Future<bool> signUp(Member member) async {
    try {
      return _auth
          .signUpWithEmailAndPassword(
            member.login,
            member.mdp,
          )
          .then((value) => true)
          .catchError((_) => false);
    } catch (e) {
      return false;
    }
  }
}
