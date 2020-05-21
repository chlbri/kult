import 'package:auto_route/auto_route_annotations.dart';

import '../screens/SignIn.dart';
import '../screens/SignUp.dart';
import '../screens/SplashScreen.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashScreen i;
  SignUp signUp;
  SignIn signIn;
}
