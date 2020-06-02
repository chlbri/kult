import 'package:kult/domain/entities/member.dart';

abstract class IAuth {
  Future signUp(Member data);
  Future signIn(Member data);
}
