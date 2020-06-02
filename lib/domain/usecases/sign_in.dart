import 'package:kult/core/utils.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/repos/i_auth.dart';

class SignIn {
  final IAuth auth;

  SignIn(this.auth);

  call(Member member) {
    assert(isNullAny([member.login, member.mdp]));
    return auth.signIn(member);
  }
}
