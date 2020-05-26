import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kult/ui/android/router/router.gr.dart';
import 'package:kult/ui/contrats/screen.dart';
import 'package:kult/ui/contrats/screen_routing.dart';

const minButtonWidth = 120.0;

class Splashscreen extends StatelessWidget with ScreenRouting {
  const Splashscreen({Key key}) : super(key: key);

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
                          style: TextStyle(
                              color: Colors.yellow[300], fontSize: 17),
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