import 'package:flutter/material.dart';

class ScreenBackground extends StatelessWidget {
  final BoxDecoration background;
  final Widget child;
  const ScreenBackground({
    Key key,
    @required this.background,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: DecoratedBox(
        decoration: background ??
            BoxDecoration(
              color: Colors.grey[100],
            ),
        child: child,
      ),
    );
  }
}
