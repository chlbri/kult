import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:kult/external/ui/android/widgets/column_form.dart';
import 'input_screen.dart';
import '../../contrats/screen.dart';
import '../widgets/colum_form_separator.dart';
import '../widgets/sign_form_field.dart';
import '../../contrats/screen_routing.dart';

const requiredField = 'Champ obligatoire';

class SignUp extends Screen with ScreenRouting {
  const SignUp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String pwd = '';
    final _formKey = GlobalKey<FormState>();
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
        Image.asset('assets/img/header_txt.png'),
        SizedBox(height: 50),
        SvgPicture.asset(
          'assets/svg/inscription_header_txt.svg',
          height: 60,
        ),
        SizedBox(height: 50),
        ColumnForm(
          formKey: _formKey,
          children: [
            SignFormField(
              label: 'Nom',
              validator: RequiredValidator(errorText: "Champ requis"),
            ),
            COLUMN_FORM_SEPARATOR,
            SignFormField(
              label: 'Prénoms',
              validator: RequiredValidator(errorText: "Champ requis"),
            ),
            COLUMN_FORM_SEPARATOR,
            SignFormField(
              label: 'Téléphone',
              keyboard: TextInputType.phone,
              validator: RequiredValidator(errorText: "Champ requis"),
            ),
            COLUMN_FORM_SEPARATOR,
            SignFormField(
              label: 'Email',
              keyboard: TextInputType.emailAddress,
              validator: MultiValidator([
                RequiredValidator(errorText: "Champ requis"),
                EmailValidator(errorText: "Email non valide"),
              ]),
            ),
            COLUMN_FORM_SEPARATOR,
            SignFormField(
              label: 'Mot de passe',
              onChanged: (val) => pwd = val,
              validator: RequiredValidator(errorText: "Champ requis"),
              obscureText: true,
            ),
            COLUMN_FORM_SEPARATOR,
            SignFormField(
              label: 'Confirmation',
              validator: (val) {
                if (val.isEmpty) return 'Champ requis';
                if (val != pwd) return 'Non identiques';
                return null;
              },
              obscureText: true,
            ),
          ],
        ),
      ],
      stackedFields: <Widget>[
        Positioned(
          bottom: 20,
          child: Container(
            child: ButtonTheme(
              minWidth: 200,
              child: FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onPressed: () => {
                  if (_formKey.currentState.validate())
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text('Inscription ...'),
                      duration: Duration(milliseconds: 700),
                    ))
                },
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(color: Color(0xFF25A3BC), fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
