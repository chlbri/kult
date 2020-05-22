import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kult/external/ui/android/widgets/screen_background.dart';
import '../../contrats/screen_routing.dart';
import '../../contrats/screen.dart';

class Home extends Screen with ScreenRouting {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenBackground(
      background: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/home_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
        child: Column(
          children: <Widget>[
            Image.asset('assets/img/header_txt.png', height: 30),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.white,
                width: 2,
              )),
              child: const Text(
                'ESPACE MEMBRE',
                style: TextStyle(
                  fontSize: 25,
                  decoration: TextDecoration.none,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: size.height / 5),
            Container(
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: <Widget>[
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
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'FAIS TON',
                            style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.none,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
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
                      SizedBox(
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
                  SizedBox(height: 20),
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
                          children: <Widget>[
                            KultChoiceButton(
                              margin: EdgeInsets.fromLTRB(0, 0, 15, 2),
                              data: 'Samedi 8h à 10h',
                            ),
                            KultChoiceButton(
                              margin: EdgeInsets.fromLTRB(0, 0, 15, 2),
                              data: 'Samedi 11h à 13h',
                            ),
                            KultChoiceButton(
                              margin: EdgeInsets.fromLTRB(0, 0, 15, 2),
                              data: 'Dimanche 7h30 à 9h30',
                            ),
                            KultChoiceButton(
                              margin: EdgeInsets.fromLTRB(0, 0, 15, 2),
                              data: 'Dimanche 11h à 13h',
                            ),
                          ],
                        ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KultChoiceButton extends StatelessWidget {
  final String data;
  final IconData iconData;
  final EdgeInsetsGeometry margin;
  const KultChoiceButton({
    Key key,
    @required this.data,
    this.iconData,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(right: 10),
      child: ButtonTheme(
        minWidth: 180,
        child: FlatButton(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          splashColor: Colors.white54,
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          textColor: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              iconData ?? Icon(Icons.add_alert),
              SizedBox(width: 10),
              Text(
                data,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
