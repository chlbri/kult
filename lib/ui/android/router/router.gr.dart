// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:kult/ui/android/screens/initial.dart';
import 'package:kult/ui/android/screens/sign_up.dart';
import 'package:kult/ui/android/screens/sign_in.dart';
import 'package:kult/ui/android/screens/home.dart';
import 'package:kult/ui/android/screens/register_many.dart';
import 'package:kult/ui/android/screens/list_known.dart';
import 'package:kult/ui/android/screens/set_member.dart';
import 'package:kult/domain/entities/member.dart';

abstract class Routes {
  static const i = '/';
  static const signUp = '/sign-up';
  static const signIn = '/sign-in';
  static const home = '/home';
  static const register = '/register';
  static const list = '/list';
  static const setMember = '/set-member';
  static const all = {
    i,
    signUp,
    signIn,
    home,
    register,
    list,
    setMember,
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
          builder: (context) => Initial(),
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
      case Routes.register:
        if (hasInvalidArgs<RegisterManyArguments>(args)) {
          return misTypedArgsRoute<RegisterManyArguments>(args);
        }
        final typedArgs =
            args as RegisterManyArguments ?? RegisterManyArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => RegisterMany(key: typedArgs.key),
          settings: settings,
        );
      case Routes.list:
        if (hasInvalidArgs<ListKnownArguments>(args)) {
          return misTypedArgsRoute<ListKnownArguments>(args);
        }
        final typedArgs = args as ListKnownArguments ?? ListKnownArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => ListKnown(key: typedArgs.key),
          settings: settings,
        );
      case Routes.setMember:
        if (hasInvalidArgs<SetMemberArguments>(args)) {
          return misTypedArgsRoute<SetMemberArguments>(args);
        }
        final typedArgs = args as SetMemberArguments ?? SetMemberArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              SetMember(key: typedArgs.key, data: typedArgs.data),
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

//RegisterMany arguments holder class
class RegisterManyArguments {
  final Key key;
  RegisterManyArguments({this.key});
}

//ListKnown arguments holder class
class ListKnownArguments {
  final Key key;
  ListKnownArguments({this.key});
}

//SetMember arguments holder class
class SetMemberArguments {
  final Key key;
  final Member data;
  SetMemberArguments({this.key, this.data});
}
