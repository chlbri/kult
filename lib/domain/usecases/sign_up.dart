import 'package:kult/core/utils.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/repos/i_member.dart';

import '../repos/i_auth.dart';

class SignUp {
  final IAuth auth;
  SignUp(this.auth);

  call(Member member) {
    assert(isNullAny([member.login, member.mdp]));
    return auth.signUp(member);
  }
}
