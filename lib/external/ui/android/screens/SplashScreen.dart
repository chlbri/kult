import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../contrats/screen_routing.dart';
import '../router/router.gr.dart';

const minButtonWidth = 120.0;

class SplashScreen extends StatelessWidget with ScreenRouting {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/welcome_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SvgPicture.asset('assets/svg/welcome_txt.svg'),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Row(
                  children: [
                    ButtonTheme(
                      minWidth: minButtonWidth,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15),
                        ),
                        color: Color(0xFF57AFC6),
                        onPressed: () =>
                            // null,
                            pushNamed(Routes.signIn),
                        child: Text(
                          "Se Connecter",
                          style: TextStyle(color: Colors.yellow[300], fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    ButtonTheme(
                      minWidth: minButtonWidth,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15),
                        ),
                        color: Color(0xFF1C7D8F),
                        onPressed: () =>
                            // null,
                            pushNamed(Routes.signUp),
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
