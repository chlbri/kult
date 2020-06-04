import 'package:flutter/material.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/ui/contrats/screen_routing.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

mixin Check {
  String get text;
  String get msg;
}

extension ChoiceListExtension on ChoiceList {
  String get text {
    String out;
    switch (this) {
      case ChoiceList.SAMEDI1:
        out = 'Samedi 8h à 10h';
        break;
      case ChoiceList.SAMEDI2:
        out = 'Samedi 11h à 13h';
        break;
      case ChoiceList.DIMANCHE1:
        out = 'Dimanche 7h30 à 9h30';
        break;
      case ChoiceList.DIMANCHE2:
        out = 'Dimanche 11h à 13h';
        break;
      case ChoiceList.NONE:
        // TODO: Handle this case.
        break;
    }
    return out;
  }

  String get msg {
    String out;
    switch (this) {
      case ChoiceList.SAMEDI1:
        out = 'qui se tiendra ce samedi, de 8h à 10h';
        break;
      case ChoiceList.SAMEDI2:
        out = 'qui se tiendra ce samedi, de 11h à 13h';
        break;
      case ChoiceList.DIMANCHE1:
        out = 'qui se tiendra ce dimanche, de 7h30 à 9h30';
        break;
      case ChoiceList.DIMANCHE2:
        out = 'qui se tiendra ce dimanche, de 11h à 13h';
        break;
      case ChoiceList.NONE:
        // TODO: Handle this case.
        break;
    }
    return out;
  }
}

class CheckboxKult extends StatelessWidget with ScreenRouting {
  final IconData iconData;
  final ChoiceList choice;
  final EdgeInsetsGeometry margin;
  final bool enabled;
  final VoidCallback onPressed;

  const CheckboxKult({
    Key key,
    this.iconData = Icons.add_alert,
    this.margin,
    @required this.choice,
    this.enabled,
    this.onPressed,

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        margin: margin ?? EdgeInsets.only(right: 10),
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: 450),
          crossFadeState: enabled
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: FlatButton(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            splashColor: Colors.white54,
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            textColor: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  iconData,
                  size: size.width * 0.035,
                ),
                SizedBox(width: 10),
                Text(
                  choice.text,
                  style: TextStyle(fontSize: size.width * 0.035),
                )
              ],
            ),
            onPressed: onPressed,
          ),
          secondChild: FlatButton(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            splashColor: Colors.black54,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            textColor: Colors.black87,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  iconData,
                  size: size.width * 0.035,
                ),
                SizedBox(width: 10),
                Text(
                  choice.text,
                  style: TextStyle(fontSize: size.width * 0.035),
                )
              ],
            ),
            onPressed: onPressed ,
          ),
        ));
  }
}
