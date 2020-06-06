import 'package:kult/domain/entities/member.dart';

abstract class IAuth {
  Future<String> signUp(Member data);
  Future<bool> signIn(Member data);
  Future<bool> resetPassword(String data);
}
