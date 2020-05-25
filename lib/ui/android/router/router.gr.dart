// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kult/ui/android/screens/home.dart';
import 'package:kult/ui/android/screens/sign_in.dart';
import 'package:kult/ui/android/screens/sign_up.dart';
import 'package:kult/ui/android/screens/splashscreen.dart';


abstract class Routes {
  static const i = '/';
  static const signUp = '/sign-up';
  static const signIn = '/sign-in';
  static const home = '/home';
  static const all = {
    i,
    signUp,
    signIn,
    home,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.i:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplashScreen(),
          settings: settings,
        );
      case Routes.signUp:
        if (hasInvalidArgs<SignUpArguments>(args)) {
          return misTypedArgsRoute<SignUpArguments>(args);
        }
        final typedArgs = args as SignUpArguments ?? SignUpArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignUp(key: typedArgs.key),
          settings: settings,
        );
      case Routes.signIn:
        if (hasInvalidArgs<SignInArguments>(args)) {
          return misTypedArgsRoute<SignInArguments>(args);
        }
        final typedArgs = args as SignInArguments ?? SignInArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignIn(key: typedArgs.key),
          settings: settings,
        );
      case Routes.home:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Home(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//SignUp arguments holder class
class SignUpArguments {
  final Key key;
  SignUpArguments({this.key});
}

//SignIn arguments holder class
class SignInArguments {
  final Key key;
  SignInArguments({this.key});
}
