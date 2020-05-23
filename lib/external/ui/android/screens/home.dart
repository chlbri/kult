import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kult/external/ui/android/widgets/carousel_card.dart';
import 'package:kult/external/ui/android/widgets/carousel_many.dart';
import '../widgets/kult_choice_button.dart';
import '../widgets/screen_background.dart';
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
        physics: ClampingScrollPhysics(),
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
            SizedBox(height: size.height / 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: <Widget>[
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height / 30),
            Column(
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
                SizedBox(height: 2),
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
                            // margin: EdgeInsets.only( bottom: 2),
                            data: 'Samedi 8h à 10h',
                          ),
                          KultChoiceButton(
                            // margin: EdgeInsets.fromLTRB(0, 0, 15, 2),
                            data: 'Samedi 11h à 13h',
                          ),
                          KultChoiceButton(
                            // margin: EdgeInsets.fromLTRB(0, 0, 15, 2),
                            data: 'Dimanche 7h30 à 9h30',
                          ),
                          KultChoiceButton(
                            // margin: EdgeInsets.fromLTRB(0, 0, 15, 2),
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
            SizedBox(height: size.height / 50),
            SvgPicture.asset('assets/svg/church_life_txt.svg', height: 40,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: <Widget>[
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
