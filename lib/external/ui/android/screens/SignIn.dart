import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kult/external/ui/contrats/input_screen.dart';

import '../widgets/sign_form_field.dart';
import '../../contrats/screen_routing.dart';

class SignIn extends StatelessWidget with ScreenRouting {
  const SignIn({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _scaffoldState = GlobalKey<ScaffoldState>();

    return InputScreen(
      scaffoldKey: _scaffoldState,
      background: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/sign_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      children: [
        Image.asset('assets/img/header_txt.png', height: 30),
        SizedBox(height: 50),
        SvgPicture.asset(
          'assets/svg/connection_header_txt.svg',
          height: 60,
        ),
        SizedBox(height: 120),
        Form(
          key: _formKey,
          child: Column(
            children: [
              SignFormField(
                label: 'Email / Tél',
                validator: RequiredValidator(errorText: "Champ requis"),
              ),
              const SizedBox(height: 50),
              SignFormField(
                label: 'Mot de passe',
                validator: RequiredValidator(errorText: "Champ requis"),
                obscureText: true,
                keyboard: TextInputType.visiblePassword,
              ),
            ],
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
              onPressed: () => {
                if (_formKey.currentState.validate())
                  _scaffoldState.currentState.showSnackBar(
                    SnackBar(
                      content: Text('Inscription ...'),
                    ),
                  )
              },
              child: const Text(
                "Se connecter",
                style: TextStyle(color: Color(0xFF25A3BC), fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
    // GestureDetector(
    //   behavior: HitTestBehavior.opaque,
    //   onTap: () {
    //     FocusScope.of(context).requestFocus(new FocusNode());
    //   },
    //   child: Stack(
    //     alignment: Alignment.topCenter,
    //     children: [
    //       Scaffold(
    //         key: _scaffoldState,
    //         body: FractionallySizedBox(
    //           widthFactor: 1,
    //           heightFactor: 1,
    //           child: DecoratedBox(
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                 image: AssetImage('assets/img/sign_background.png'),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //             child: SingleChildScrollView(
    //               padding: EdgeInsets.fromLTRB(15, 50, 15, 30),
    //               child: Column(
    //                 children: <Widget>[
    //                   Image.asset('assets/img/header_txt.png', height: 30),
    //                   SizedBox(height: 50),
    //                   SvgPicture.asset(
    //                     'assets/svg/connection_header_txt.svg',
    //                     height: 60,
    //                   ),
    //                   SizedBox(height: 120),
    //                   Form(
    //                     key: _formKey,
    //                     child: Column(
    //                       children: [
    //                         SignFormField(
    //                           label: 'Email / Tél',
    //                           validator:
    //                               RequiredValidator(errorText: "Champ requis"),
    //                         ),
    //                         const SizedBox(height: 50),
    //                         SignFormField(
    //                           label: 'Mot de passe',
    //                           validator:
    //                               RequiredValidator(errorText: "Champ requis"),
    //                           obscureText: true,
    //                           keyboard: TextInputType.visiblePassword,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Expanded(child: Container(),),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 20,
    //         child: ButtonTheme(
    //           height: 40,
    //           minWidth: 200,
    //           child: FlatButton(
    //             color: Colors.white,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(15.0),
    //             ),
    //             onPressed: () => {
    //               if (_formKey.currentState.validate())
    //                 _scaffoldState.currentState.showSnackBar(
    //                   SnackBar(
    //                     content: Text('Inscription ...'),
    //                   ),
    //                 )
    //             },
    //             child: const Text(
    //               "Se connecter",
    //               style: TextStyle(color: Color(0xFF25A3BC), fontSize: 18),
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
