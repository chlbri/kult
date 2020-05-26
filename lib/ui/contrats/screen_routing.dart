import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:kult/ui/contrats/screen.dart';

import '../android/router/router.gr.dart';

mixin ScreenRouting on Widget {
  Future pushNamed(
    String route, {
    Object arguments,
    OnNavigationRejected onReject,
  }) {
    assert(Routes.all.contains(route));
    return ExtendedNavigator.ofRouter<Router>().pushNamed(
      route,
      arguments: arguments,
      onReject: onReject,
    );
  }

  Future pushReplacementNamed(
    String route, {
    Object result,
    Object arguments,
    OnNavigationRejected onReject,
  }) {
    assert(Routes.all.contains(route));
    return ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(
      route,
      result: result,
      arguments: arguments,
      onReject: onReject,
    );
  }

  Future popAndPushNamed(
    String route, {
    Object result,
    Object arguments,
  }) {
    assert(Routes.all.contains(route));
    return ExtendedNavigator.ofRouter<Router>().popAndPushNamed(
      route,
      result: result,
      arguments: arguments,
    );
  }

  void pop<T>([T result]) {
    return ExtendedNavigator.ofRouter<Router>().pop(result);
  }

  Future pushNamedAndRemoveUntil(
    String route,
    RoutePredicate predicate, {
    Object arguments,
    OnNavigationRejected onReject,
  }) {
    assert(Routes.all.contains(route));
    return ExtendedNavigator.ofRouter<Router>().pushNamedAndRemoveUntil(
      route,
      predicate,
      arguments: arguments,
      onReject: onReject,
    );
  }
}

typedef ScreenWidget = ScreenRouting Function(BuildContext);
