import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/repos/auth.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/repos/i_auth.dart';

class ResetPassword {
  final IAuth auth;

  ResetPassword(this.auth);

  Future<bool> call(String data) {
    assert(!isNullString(data));
    return auth.resetPassword(data);
  }
}

final resetPasswordFireBaseAuthContainer = ResetPassword(
  FireStoreAuthContainer(FirebaseAuthService()),
);
