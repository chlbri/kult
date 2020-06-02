import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/repos/i_auth.dart';

class Auth extends IAuth {
  final FirebaseAuthService source;
  Auth({
    this.source,
  });

  @override
  signUp(data) => source.signUpWithEmailAndPassword(
        data.login,
        data.mdp,
      );

  @override
  signIn(data) => source.signInWithEmailAndPassword(
        data.login,
        data.mdp,
      );
}
