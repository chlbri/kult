import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/repos/auth.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/repos/i_member.dart';

import '../repos/i_auth.dart';

class SignUp {
  final IAuth auth;
  SignUp(this.auth);

  Future<String> call(Member member) {
    assert(!isNullStringAny([member.login, member.mdp]));
    return auth.signUp(member);
  }
}

final signUpFireBaseAuthContainer = SignUp(
  FireStoreAuthContainer(FirebaseAuthService()),
);
