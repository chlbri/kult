import 'package:flutter/material.dart';

import '../../contrats/screen.dart';
import '../widgets/screen_background.dart';

///
class InputScreen extends Screen {
  ///Tous les champs que vous voulez utilisez et autres (pour décorer...)
  final List<Widget> children;

  ///L'arrière-plan
  final Decoration background;

  final EdgeInsetsGeometry padding;

  ///Il est préférable d'utiliser [Positioned] ici
  final List<Widget> stackedFields;

  ///Pour les snackbars
  final GlobalKey<ScaffoldState> scaffoldKey;

  const InputScreen({
    @required this.children,
    this.background,
    this.padding,
    this.stackedFields,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            key: scaffoldKey,
            body: ScreenBackground(
              background: background ??
                  BoxDecoration(
                    color: Colors.grey[100],
                  ),
              child: SingleChildScrollView(
                  child: Container(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(
                  vertical: 50,
                ),
                child: Column(
                  children: children,
                ),
              )),
            ),
          ),
          ...stackedFields,
        ],
      ),
    );
  }
}
