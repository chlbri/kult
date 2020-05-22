import 'package:auto_route/auto_route_annotations.dart';
import 'package:kult/external/ui/android/screens/home.dart';

import '../screens/sign_in.dart';
import '../screens/sign_up.dart';
import '../screens/splashscreen.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashScreen i;
  SignUp signUp;
  SignIn signIn;
  Home home;
}
