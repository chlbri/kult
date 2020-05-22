import 'package:flutter/material.dart';
import 'package:kult/external/ui/android/widgets/screen_background.dart';
import '../../contrats/screen.dart';

///
class InputScreen extends Screen {
  ///Tous les champs que vous voulez utilisez et autres (pour décorer...)
  final List<Widget> children;

  ///L'arrière-plan
  final Decoration background;

  ///Il est préférable d'utiliser [Positioned] ici
  final List<Widget> stackedFields;

  ///Pour les snackbars
  final GlobalKey<ScaffoldState> scaffoldKey;

  const InputScreen({
    this.scaffoldKey,
    @required this.children,
    this.stackedFields,
    this.background,
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
                padding: EdgeInsets.fromLTRB(15, 50, 15, 50),
                child: Column(
                  children: children,
                ),
              ),
            ),
          ),
          ...stackedFields,
        ],
      ),
    );
  }
}
