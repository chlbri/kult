import 'package:auto_route/auto_route_annotations.dart';

import 'package:kult/ui/android/screens/list_known.dart';
import 'package:kult/ui/android/screens/register_many.dart';

import '../screens/home.dart';
import '../screens/initial.dart';
import '../screens/sign_in.dart';
import '../screens/sign_up.dart';
import '../screens/set_member.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  Initial i;
  SignUp signUp;
  SignIn signIn;
  Home home;
  RegisterMany register;
  ListKnown list;
  SetMember setMember;
}
