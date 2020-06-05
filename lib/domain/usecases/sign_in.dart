import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/repos/auth.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/repos/i_auth.dart';

class SignIn {
  final IAuth auth;

  SignIn(this.auth);

  Future<bool> call(Member member) {
    assert(!isNullStringAny([member.login, member.mdp]));
    return auth.signIn(member);
  }
}

final signInFireBaseAuthContainer = SignIn(
  FireStoreAuthContainer(FirebaseAuthService()),
);
