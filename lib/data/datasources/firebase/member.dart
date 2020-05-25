import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/datasources/firebase/services/database.dart';
import 'package:kult/data/models/member.dart';

class MemberSource extends DataBaseService {
  final MemberModel member;
  final auth = AuthService();

  MemberSource(this.member) : super("Member", member);

  Future<bool> signIn() {
    return auth.signInWithEmailAndPassword(
      member.login,
      member.mdp,
    );
    // return await collection
    //     .where('phoneNumber', isNull: true)
    //     .getDocuments()
    //     .then((val) {
    //       final value = val.documents;

    //       return value.map((e) => e.data).length;
    //     })
    //     .catchError((e) => print(e))
    //     .whenComplete(() => print("reach database"));
  }

  signUp() async {
    print(member.login);
    'chlbri.blac@gmail.com';
    final result = await auth.signUpWithEmailAndPassword(
      member.login,
      member.mdp,
    );
    if (result.runtimeType == FirebaseUser) {
      print('Ready to update..');
      return super.update(result.uid);
    }
  }
}
