import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;
import 'package:kult/data/datasources/firebase/choice.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/datasources/firebase/services/database.dart';
import 'package:kult/data/models/member.dart';

class MemberSource extends DataBaseService {
  final MemberModel member;
  final auth = AuthService();

  MemberSource([this.member]) : super("Member", member);

  Future<bool> signIn() {
    return auth.signInWithEmailAndPassword(
      member.login,
      member.mdp,
    );
  }

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

  Future<bool> signUp() async {
    try {
      return auth
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
