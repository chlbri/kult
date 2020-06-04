import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/datasources/firebase/services/database.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/member.dart';

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
      snap.data..['uid'] = uid,
    );
  }

  Future<List<Member>> readMany(MemberModel data) async {
    Query query = collection.where('createdAt');
    final _data = data.toJson();
    _data.removeWhere(
      (key, value) =>
          key == 'uid' || value == null || value is String && value.isEmpty,
    );
    _data.forEach((key, value) {
      query = query.where(key, isEqualTo: value);
    });
    return await query.getDocuments().then(
          (value) => value.documents
              .map(
                (e) => MemberModel.fromJson(e.data)
              )
              .toList(),
        );
  }

  Future<String> create(MemberModel model) async {
    final json = model.toJson();
    return collection.add(json..remove("mdp")..remove("uid")).then(
      (val) {
        print('Creating...');
        model.uid = val.documentID;
        print(model.uid);
        return val.documentID;
      },
    ).catchError(
      (e) {
        print('Rejecting...');
        return null;
      },
    );
  }

  Future<bool> signUp() async {
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
