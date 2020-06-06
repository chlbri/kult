import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:kult/domain/entities/choice.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/usecases/choose_kult.dart';
import 'package:kult/ui/android/widgets/checkbox_group.dart';

import '../../contrats/screen_routing.dart';
import 'input_screen.dart';

const requiredField = 'Champ obligatoire';

final alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: const TextStyle(fontWeight: FontWeight.bold),
  buttonAreaPadding: EdgeInsets.all(7),
  animationDuration: Duration(milliseconds: 700),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.grey[700],
  ),
);

class SetMember extends StatelessWidget {
  final Member data;

  const SetMember({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _SetMember(data: data),
    );
  }
}

class _SetMember extends StatefulWidget {
  final Member data;

  const _SetMember({Key key, this.data}) : super(key: key);

  @override
  _SetMemberState createState() => _SetMemberState();
}

class _SetMemberState extends State<_SetMember> with ScreenRouting {
  bool firstEnter = true;

  @override
  void initState() {
    // TODO: implement initState
    firstEnter = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('obtainning...');
    const style = TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
    final Member member = widget.data ?? Member();
    print(member.uid);
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return InputScreen(
      scaffoldKey: _scaffoldKey,
      background: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/sign_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/img/header_txt.png', height: 30),
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            const Expanded(
              flex: 1,
              child: SizedBox(
                height: 5,
                child: DecoratedBox(
                  //position: DecorationPosition.foreground,
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: <Widget>[
                const Text(
                  'FAIS TON',
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'CHOIX',
                  style: TextStyle(
                    fontSize: 25,
                    decoration: TextDecoration.none,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 5,
                child: DecoratedBox(
                  //position: DecorationPosition.foreground,
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              if (member.lastName != null) ...[
                Text(
                  member.lastName ?? 'Nom inconnu',
                  style: style,
                ),
                SizedBox(height: 10),
              ],
              if (member.firstNames != null) ...[
                Text(
                  member.firstNames ?? 'Prénoms inconnus',
                  style: style,
                ),
                SizedBox(height: 10),
              ],
              if (member.phoneNumber != null) ...[
                Text(
                  member.phoneNumber ?? 'Numéro inconnu',
                  style: style,
                ),
                SizedBox(height: 10),
              ],
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: Transform.rotate(
                angle: -pi / 7,
                child: Image.asset(
                  'assets/img/kult_choice_phone.png',
                ),
              ),
            ),
            IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CheckboxGroup(
                    groupChoice: member.choice,
                    direction: Axis.vertical,
                    model: () => member,
                    alert: true,
                    enabledQuery: (e, [model]) async {
                      return await chooseKultContainer
                          .update(Choice()..choice = e, uid: model().uid)
                          ?.then((_) => member.choice = e);
                    },
                    disabledQuery: (e, [model]) async {
                      print(member.uid);
                      return chooseKultContainer
                          .remove(model().uid)
                          .then((_) => member.choice = null);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      size: 20,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Retour",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                onPressed: () {
                  pop(member);
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(color: Colors.white),
        )
      ],
      stackedFields: <Widget>[],
    );
  }
}
