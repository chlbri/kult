import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/usecases/register.dart';
import 'package:kult/domain/usecases/sign_up.dart';
import 'package:kult/ui/android/router/router.gr.dart';
import 'package:kult/ui/android/widgets/column_form.dart';

import '../../contrats/screen.dart';
import '../widgets/colum_form_separator.dart';
import '../widgets/sign_form_field.dart';
import '../../contrats/screen_routing.dart';
import 'input_screen.dart';

const requiredField = 'Champ obligatoire';

class SignUp extends Screen with ScreenRouting {
  const SignUp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Member member = MemberModel();
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return InputScreen(
      scaffoldKey: scaffoldKey,
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
        SizedBox(height: 30),
        SvgPicture.asset(
          'assets/svg/inscription_header_txt.svg',
          height: 60,
        ),
        SizedBox(height: 50),
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(children:[
              SignFormField(
                label: 'Nom',
                onChanged: (val) => member.lastName = val,
                validator: RequiredValidator(errorText: "Champ requis"),
              ),
              COLUMN_FORM_SEPARATOR,
              SignFormField(
                label: 'Prénoms',
                onChanged: (val) => member.firstNames = val,
                validator: RequiredValidator(errorText: "Champ requis"),
              ),
              COLUMN_FORM_SEPARATOR,
              SignFormField(
                label: 'Téléphone',
                keyboard: TextInputType.phone,
                onChanged: (val) => member.phoneNumber = val,
                validator: RequiredValidator(errorText: "Champ requis"),
              ),
              COLUMN_FORM_SEPARATOR,
              SignFormField(
                label: 'Email',
                keyboard: TextInputType.emailAddress,
                onChanged: (val) => member.login = val.trim(),
                validator: MultiValidator([
                  RequiredValidator(errorText: "Champ requis"),
                  EmailValidator(errorText: "Email non valide"),
                ]),
              ),
              COLUMN_FORM_SEPARATOR,
              SignFormField(
                label: 'Mot de passe',
                onChanged: (val) => member.mdp = val,
                validator: RequiredValidator(errorText: "Champ requis"),
                obscureText: true,
              ),
              COLUMN_FORM_SEPARATOR,
              SignFormField(
                label: 'Confirmation',
                validator: (val) {
                  if (val.isEmpty) return 'Champ requis';
                  if (val != member.mdp) return 'Non identiques';
                  return null;
                },
                obscureText: true,
              ),
            ],),
          ),
        ),
        SizedBox(height: 70),
        ButtonTheme(
          minWidth: 200,
          child: FlatButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            onPressed: _signUp(member, formKey, scaffoldKey),
            child: const Text(
              "S'inscrire",
              style: TextStyle(color: Color(0xFF25A3BC), fontSize: 18),
            ),
          ),
        ),
      ],
      stackedFields: <Widget>[
        // Positioned(
        //   bottom: 20,
        //   child: ButtonTheme(
        //     minWidth: 200,
        //     child: FlatButton(
        //       color: Colors.white,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(15.0),
        //       ),
        //       onPressed: _signUp(_formKey, _scaffoldKey),
        //       child: const Text(
        //         "S'inscrire",
        //         style: TextStyle(color: Color(0xFF25A3BC), fontSize: 18),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  _signUp(
    Member member,
    GlobalKey<FormState> _formKey,
    GlobalKey<ScaffoldState> _scaffoldState,
  ) {
    return () async {
      if (_formKey.currentState.validate()) {
        _scaffoldState.currentState.showSnackBar(
          SnackBar(
            content: Text('Inscription ...'),
            duration: Duration(milliseconds: 200),
          ),
        );
        //member.login = member.lastName;
        await signUpFireBaseAuthContainer(member)
            .then((value) => member.uid = value);

        if (!isNullString(member.uid)) {
          registerContainer
              .update(member)
              .then((value) => pushReplacementNamed(Routes.home));
        }
      }
    };
  }
}
