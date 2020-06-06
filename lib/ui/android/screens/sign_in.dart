import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kult/data/datasources/firebase/choice.dart';
import 'package:kult/data/datasources/firebase/member.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/models/choice.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/domain/usecases/reset_password.dart';
import 'package:kult/domain/usecases/sign_in.dart';
import '../router/router.gr.dart';
import '../widgets/column_form.dart';
import 'input_screen.dart';
import '../../contrats/screen.dart';

import '../widgets/sign_form_field.dart';
import '../../contrats/screen_routing.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with ScreenRouting {
  bool _resetPass;

  @override
  void initState() {
    super.initState();
    _resetPass = false;
  }

  @override
  Widget build(BuildContext context) {
    final model = Member();
    final _formKey = GlobalKey<FormState>();
    final _scaffoldState = GlobalKey<ScaffoldState>();

    final _auth = FirebaseAuthService();
    return InputScreen(
      scaffoldKey: _scaffoldState,
      background: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/sign_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/img/header_txt.png', height: 30),
        ),
        SizedBox(height: 30),
        SvgPicture.asset(
          'assets/svg/connection_header_txt.svg',
          height: 40,
        ),
        SizedBox(height: 120),
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:40),
              child: Column(
                children: [
                  SignFormField(
                    label: 'Email',
                    onChanged: (value) => model.login = value.trim(),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Champ requis"),
                      EmailValidator(errorText: "Email non valide"),
                    ]),
                  ),
                  const SizedBox(height: 50),
                  if (!_resetPass)
                    SignFormField(
                      label: 'Mot de passe',
                      onChanged: (value) => model.mdp = value.trim(),
                      validator: RequiredValidator(errorText: "Champ requis"),
                      obscureText: true,
                      keyboard: TextInputType.visiblePassword,
                    ),
                ],
              ),
            )),
        SizedBox(height: 50),
        if (!_resetPass)
          Material(
            elevation: 100,
            color: Colors.transparent,
            child: InkWell(
              child: Text(
                'Mode passe oublié ?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                setState(() {
                  _resetPass = true;
                });
              },
            ),
          ),
      ],
      stackedFields: <Widget>[
        Positioned(
          bottom: 20,
          child: ButtonTheme(
            height: 40,
            minWidth: 200,
            child: FlatButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              onPressed: () async {
                _resetPass
                    ? _resetPassword(model.login, _formKey, _scaffoldState)
                    : _signIn(model, _formKey, _scaffoldState);
                //await _auth.signInAnon();
              },
              child: Text(
                _resetPass ? "Réinitialiser le mot de passe" : "Se connecter",
                style: TextStyle(color: Color(0xFF25A3BC), fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _signIn(
    Member model,
    GlobalKey<FormState> _formKey,
    GlobalKey<ScaffoldState> _scaffoldState,
  ) async {
    if (_formKey.currentState.validate()) {
      // print(MemberSource(model).login());
      _scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text('Connexion '),
          duration: Duration(seconds: 1),
        ),
      );
      if (await signInFireBaseAuthContainer(model)) {
        pushNamedAndRemoveUntil(Routes.home, (route) => false);
      }
    }
  }

  _resetPassword(
    String data,
    GlobalKey<FormState> _formKey,
    GlobalKey<ScaffoldState> _scaffoldState,
  ) async {
    if (_formKey.currentState.validate()) {
      // print(MemberSource(model).login());
      _scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text('Réinitialisation ... '),
          duration: Duration(seconds: 1),
        ),
      );
      resetPasswordFireBaseAuthContainer(data).then(
        (val) => setState(
          () {
            _resetPass = false;
          },
        ),
      );
    }
  }
}
