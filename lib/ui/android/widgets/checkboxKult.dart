import 'package:flutter/material.dart';
import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/choice.dart';
import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/data/models/choice.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/data/repos/choice.dart';
import 'package:kult/domain/entities/choice.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/usecases/choose_kult.dart';
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
    }
    return out;
  }
}

final alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: const TextStyle(fontWeight: FontWeight.bold),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.brown[200],
  ),
);

class CheckboxKult extends StatefulWidget with ScreenRouting {
  final IconData iconData;
  final ChoiceList choice;
  final EdgeInsetsGeometry margin;
  final bool ableToRegister, enabled, alert;
  final MemberModel model;
  final VoidCallback onPressed;

  const CheckboxKult({
    Key key,
    this.iconData = Icons.add_alert,
    this.margin,
    @required this.choice,
    this.enabled,
    this.alert,
    @required this.model,
    this.ableToRegister,
    this.onPressed,
  }) : super(key: key);

  @override
  _CheckboxKultState createState() => _CheckboxKultState();
}

class _CheckboxKultState extends State<CheckboxKult> {
  bool switcher = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(CheckboxKult oldWidget) {
    super.didUpdateWidget(oldWidget);
    switcher = widget.enabled;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final alertMsg = StringBuffer();

    alertMsg.write(
        widget.model?.lastName ?? widget?.model?.firstNames ?? "Inconnu");
    alertMsg.write(' ');
    alertMsg.write(
        switcher ? "sera convié au culte" : "ne participeras plus au culte");
    alertMsg.write(' ');
    alertMsg.write(widget.choice.msg);
    alertMsg.write('.');
    final alertWidget = Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: "Choix éffectué",
      desc: alertMsg.toString(),
      content: SizedBox(width: 10),
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF0A8B9C),
          radius: BorderRadius.circular(10.0),
        ),
      ],
    );
    return Container(
      margin: widget.margin ?? EdgeInsets.only(right: 10),
      child: FlatButton(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        splashColor: switcher ? Colors.white54 : Colors.black54,
        color: switcher ? Colors.black87 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        textColor: !switcher ? Colors.black87 : Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              widget.iconData,
              size: size.width * 0.035,
            ),
            SizedBox(width: 10),
            Text(
              widget.choice.text,
              style: TextStyle(fontSize: size.width * 0.035),
            )
          ],
        ),
        onPressed: () async {
          if (widget.enabled) {
            if (widget.ableToRegister && widget.model != null) {
              chooseKultContainer
                  .update(
                Choice()..choice = widget.choice,
                uid: widget.model.uid,
              )
                  .then((val) {
                if (widget.alert) alertWidget.show();
                widget.onPressed();
              });
            }
          } else {
            if (widget.ableToRegister && widget.model != null) {
              chooseKultContainer.remove(widget.model.uid).then(
                (val) {
                  if (widget.alert) alertWidget.show();
                  widget.onPressed();
                },
              );
            }
          }
        },
      ),
    );
  }
}
