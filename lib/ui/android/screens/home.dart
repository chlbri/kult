import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kult/data/datasources/firebase/choice.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/data/models/choice.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/ui/android/router/router.gr.dart';
import 'package:kult/ui/android/widgets/carousel_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/kult_choice_button.dart';
import '../widgets/screen_background.dart';
import '../../contrats/screen_routing.dart';
import '../../contrats/screen.dart';

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

class Home extends Screen {
  @override
  Widget build(BuildContext context) => FutureHome();
}

class FutureHome extends StatefulWidget with ScreenRouting {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<FutureHome> {
  Future<ChoiceModel> _futureFonction() async {
    final uid = await ChoiceSource.uid;

    return ChoiceSource().read(uid).then(
      (value) {
        print('Future ...');
        print(uid);
        if (value != null) {
          return ChoiceModel.fromJson(value)..uid = uid;
        }
        return null;
      },
    );
  }

  bool refreshOnce = true;
  Future<ChoiceModel> get _future async => await _futureFonction();

  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final out = refreshOnce
        ? FutureBuilder(
            future: _future,
            builder: (ctx, snap) {
              if (snap.connectionState == ConnectionState.done) {
                print(snap.data);
                return SuccessHomeScreen(
                  snap: snap,
                );
              } else {
                return Scaffold(
                  body: Center(
                    child: Text('Pas de connexion Internet'),
                  ),
                );
              }
            },
          )
        : Scaffold();
    // refreshOnce = false;
    return out;
  }
}

class SuccessHomeScreen extends Screen with ScreenRouting {
  const SuccessHomeScreen({
    Key key,
    @required this.snap,
  }) : super(key: key);

  final AsyncSnapshot snap;

  @override
  Widget build(BuildContext context) {
    final alertConnection = Alert(
      context: context,
      style: alertStyle,
      type: AlertType.none,
      title: "Info",
      desc: "Confirmez votre déconnexion",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => pushReplacementNamed(Routes.i),
          color: Color(0xFF462B39),
          radius: BorderRadius.circular(10.0),
        ),
        DialogButton(
          child: Text(
            "Annuler",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF0A8B9C),
          radius: BorderRadius.circular(10.0),
        ),
      ],
    );
    final alertExit = Alert(
      context: context,
      style: alertStyle,
      type: AlertType.warning,
      title: "Faites votre choix ?",
      // desc: "Confirmez votre déconnexion",
      buttons: [
        DialogButton(
          child: const Text(
            "Quitter",
            style: TextStyle(
              color: Color(0xFFE99B22),
              fontSize: 20,
            ),
          ),
          onPressed: () => pop(true),
          color: Colors.white,
          radius: BorderRadius.circular(10.0),
        ),
        DialogButton(
          child: const Text(
            "Rester",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => pop(false),
          color: Color(0xFFE99B22),
          radius: BorderRadius.circular(10.0),
        ),
      ],
    );
    print('The snap...');
    print(snap.data != null);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return alertExit.show();
      },
      child: ScreenBackground(
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
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
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
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Material(
                          type: MaterialType.button,
                          color: Colors.transparent,
                          child: IconButton(
                            iconSize: size.width * 0.15,
                            icon: Icon(
                              Icons.do_not_disturb_alt,
                              color: Colors.white,
                            ),
                            onPressed: () => alertConnection.show(),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svg/disconnect_txt.svg',
                          height: size.width * 0.05,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height / 30),
              InProgressWidget(
                children: <Widget>[
                  CarouselCard(
                    image: "assets/img/week_book_image.png",
                    title: 'Livre de la semaine',
                  ),
                  CarouselCard(
                    image: "assets/img/god_family_image.png",
                    title: 'La famille de Dieu',
                  ),
                  CarouselCard(
                    image: "assets/img/pray_moment_image.png",
                    title: 'Moment de prière',
                  ),
                  CarouselCard(
                    image: "assets/img/gift_image.png",
                    title: 'Faire un don',
                  ),
                ],
              ),
              SizedBox(height: size.height / 30),
              KultChoices(snap: snap),
              SizedBox(height: size.height / 50),
              SvgPicture.asset(
                'assets/svg/church_life_txt.svg',
                height: 40,
              ),
              SizedBox(height: size.height / 30),
              const InProgressWidget(
                children: <Widget>[
                  CarouselCard(
                    image: "assets/img/pleading_image.png",
                    title: 'Intercéssion',
                  ),
                  CarouselCard(
                    image: "assets/img/ordinary_kult_image.png",
                    title: 'Culte ordinaire',
                  ),
                  CarouselCard(
                    image: "assets/img/special_kult_image.png",
                    title: 'Programme spécial',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KultChoices extends StatelessWidget with ScreenRouting {
  const KultChoices({
    Key key,
    @required this.snap,
  }) : super(key: key);

  final AsyncSnapshot snap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                children: ChoiceList.values
                    .map(
                      (e)  => KultChoiceButton(
                        uid: snap.data?.uid ,
                        enabled: snap.data != null ?
                            snap.data.choices?.contains(e) == false : true,
                        choice: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        RaisedButton(
          // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: Colors.white,
                width: 2,
              )),
          color: Colors.red,
          splashColor: Colors.black45,
          textColor: Colors.white,
          onPressed: () {
            pushNamed(Routes.register);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.group_add,
                size: 50,
              ),
              SizedBox(width: 20),
              Text(
                "Inscrire d'autres personnes",
                style: TextStyle(fontSize: 18),
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
    );
  }
}

class InProgressWidget extends StatelessWidget {
  final List<Widget> children;
  final Decoration hider;
  const InProgressWidget({
    Key key,
    @required this.children,
    this.hider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Stack(
        children: [
          DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: hider ??
                BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xC436A8C0), Color(0xDDFFFFFF)]),
                ),
            child: Row(
              children: children ??
                  <Widget>[
                    SizedBox(),
                  ],
            ),
          ),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                final number = (constraints.minWidth / 250).floor();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ...List.generate(
                      number,
                      (index) => Text(
                        'Bientôt disponible',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Colors.yellow[200],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
