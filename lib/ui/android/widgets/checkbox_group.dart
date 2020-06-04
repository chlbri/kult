import 'package:flutter/material.dart';
import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/choice.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/usecases/choose_kult.dart';
// import 'package:kult/ui/android/widgets/checkboxKult.dart';
import 'package:kult/ui/android/widgets/checkboxKult.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckboxGroup extends StatefulWidget {
  final ChoiceList groupChoice;
  final Axis direction;
  // final List<T> children;
  final bool Function() ableToRegister;
  final bool alert;
  final Future Function(ChoiceList e, [Member Function() model]) enabledQuery, disabledQuery;

  final Member Function() model;

  const CheckboxGroup({
    Key key,
    this.groupChoice = ChoiceList.NONE,
    @required this.direction,
    // @required this.children,
    @required this.model,
    this.ableToRegister,
    this.alert = false,
    this.enabledQuery,
    this.disabledQuery,
  }) : super(key: key);

  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  ChoiceList _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.groupChoice;
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: widget.direction,
      children: ChoiceList.values
          .where((element) => element != ChoiceList.NONE)
          .map(
            (e) => CheckboxKult(
              choice: e,
              enabled: _groupValue != e,
              onPressed: () async {
                if (_groupValue != e) {
                  await enableAction(e);
                } else {
                  await disabledAction(e);
                }
              },
            ),
          )
          .toList(),
    );
  }

  Future<void> disabledAction(ChoiceList e) async {
    if (checkFunction(widget.ableToRegister) && widget.model() != null) {
      (widget.disabledQuery(
                e,
                widget.model
              ) ??
              Future.delayed(Duration(seconds: 1)))
          .then((val) {
        setState(() {
          _groupValue = ChoiceList.NONE;
        });
        if (widget.alert) {
          getAlertWidget(
            widget.model(),
            context,
            e,
          ).show();
        }
      });
    }
  }

  Alert getAlertWidget(Member model, BuildContext context, ChoiceList choice) {
    final alertMsg = StringBuffer();
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

    alertMsg.write(model?.lastName ?? model?.firstNames ?? "Inconnu");
    alertMsg.write(' ');
    alertMsg.write(_groupValue == choice
        ? "sera convié au culte"
        : "ne participeras plus au culte");
    alertMsg.write(' ');
    alertMsg.write(choice.msg);
    alertMsg.write('.');
    return Alert(
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
  }

  Future<void> enableAction(ChoiceList e) async {
    if (checkFunction(widget.ableToRegister) && widget.model != null) {
      await (widget.enabledQuery(
                e,
                widget.model,
              ) ??
              Future.delayed(Duration(seconds: 1)))
          .then((val) {
        setState(() {
          if (_groupValue != e) _groupValue = e;
        });
        if (widget.alert) {
          getAlertWidget(widget.model(), context, e).show();
        }
      });
    }
  }
}
