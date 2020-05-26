import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kult/core/utils.dart';
import 'package:kult/data/datasources/firebase/services/auth.dart';
import 'package:kult/ui/android/screens/home.dart';
import 'package:kult/ui/android/screens/splashscreen.dart';
import '../../contrats/screen.dart';

import '../../contrats/screen_routing.dart';
import '../router/router.gr.dart';

const minButtonWidth = 120.0;

class Initial extends StatefulWidget with ScreenRouting {
  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  bool connected = false;

  
  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // AuthService()
    //     .currentUser
    //     .then(
    //       (value) => setState(() => connected = !isNull(value)),
    //     )
    //     .catchError((_) => connected = false);
  }

  @override
  Widget build(BuildContext context) => connected ? Home() : Splashscreen();
}
