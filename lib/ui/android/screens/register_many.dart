import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/core/utils.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/ui/android/router/router.gr.dart';
import 'package:kult/ui/android/widgets/column_form.dart';
import 'package:kult/ui/android/widgets/kult_choice_button.dart';
import 'package:kult/ui/android/widgets/kult_choice_button_other.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../contrats/screen.dart';
import '../widgets/colum_form_separator.dart';
import '../widgets/sign_form_field.dart';
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

class RegisterMany extends StatefulWidget with ScreenRouting {
  const RegisterMany({Key key}) : super(key: key);

  @override
  _RegisterManyState createState() => _RegisterManyState();
}

class _RegisterManyState extends State<RegisterMany> {
  @override
  Widget build(BuildContext context) {
    final MemberModel member = MemberModel();
    final _formKey = GlobalKey<FormState>();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool ableToValidate = false;
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
        SizedBox(height: 10),
        Text(
          'Inscrire une autre personne',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
          strutStyle: StrutStyle(),
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
          child: ColumnForm(
            formKey: _formKey,
            children: [
              SizedBox(height: 10),
              SignFormField(
                label: 'Nom',
                onChanged: (val) => member.lastName = val,
                validator: RequiredValidator(errorText: "Champ requis"),
              ),
              SizedBox(height: 30),
              SignFormField(
                label: 'Prénoms',
                onChanged: (val) => member.firstNames = val,
                validator: RequiredValidator(errorText: "Champ requis"),
              ),
              SizedBox(height: 30),
              SignFormField(
                label: 'Téléphone',
                keyboard: TextInputType.phone,
                onChanged: (val) {
                  member.phoneNumber = val;
                },
                validator: MultiValidator([
                  PatternValidator("[012345678][0-9]{7}", errorText: 'Numéro invalide'),
                  RequiredValidator(errorText: "Champ requis"),
                ]),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
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
                  children: ChoiceList.values
                      .map(
                        (e) => KultChoiceButtonOther(
                            ableToRegister: () {
                              return _formKey.currentState.validate();
                            },
                            choice: e,
                            model: member),
                      )
                      .toList()),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.person_add,
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Continuer',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              onPressed: () {
                setState(() => null);
              },
            ),
            RaisedButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.exit_to_app,
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "J'ai fini !",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              onPressed: () {
                widget.pop();
              },
            ),
          ],
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

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Color(0xFFBA7D40), // button color
        child: InkWell(
          splashColor: Colors.white60, // inkwell color
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.person_add,
              color: Colors.white,
              size: 50,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
