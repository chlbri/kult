// import 'package:flutter/material.dart';
// import 'package:kult/data/datasources/firebase/choice.dart';
// import 'package:kult/data/datasources/firebase/member.dart';
// import 'package:kult/data/models/choice.dart';
// import 'package:kult/data/models/member.dart';
// import 'package:kult/domain/entities/choice_list.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// extension ChoiceListExtension on ChoiceList {
//   String get text {
//     String out;
//     switch (this) {
//       case ChoiceList.SAMEDI1:
//         out = 'Samedi 8h à 10h';
//         break;
//       case ChoiceList.SAMEDI2:
//         out = 'Samedi 11h à 13h';
//         break;
//       case ChoiceList.DIMANCHE1:
//         out = 'Dimanche 7h30 à 9h30';
//         break;
//       case ChoiceList.DIMANCHE2:
//         out = 'Dimanche 11h à 13h';
//         break;
//     }
//     return out;
//   }

//   String get msg {
//     String out;
//     switch (this) {
//       case ChoiceList.SAMEDI1:
//         out = 'qui se tiendra ce samedi, de 8h à 10h';
//         break;
//       case ChoiceList.SAMEDI2:
//         out = 'qui se tiendra ce samedi, de 11h à 13h';
//         break;
//       case ChoiceList.DIMANCHE1:
//         out = 'qui se tiendra ce dimanche, de 7h30 à 9h30';
//         break;
//       case ChoiceList.DIMANCHE2:
//         out = 'qui se tiendra ce dimanche, de 11h à 13h';
//         break;
//     }
//     return out;
//   }
// }

// final alertStyle = AlertStyle(
//   animationType: AnimationType.fromTop,
//   isCloseButton: false,
//   isOverlayTapDismiss: false,
//   descStyle: const TextStyle(fontWeight: FontWeight.bold),
//   animationDuration: Duration(milliseconds: 400),
//   alertBorder: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(15.0),
//     side: BorderSide(
//       color: Colors.grey,
//     ),
//   ),
//   titleStyle: TextStyle(
//     color: Colors.brown[200],
//   ),
// );

// class KultChoiceButton extends StatefulWidget {
//   final IconData iconData;
//   final ChoiceList choice;
//   final EdgeInsetsGeometry margin;
//   final String uid;
//   final bool enabled, alert;

//   const KultChoiceButton({
//     Key key,
//     this.iconData,
//     this.margin,
//     @required this.choice,
//     this.enabled = true,
//     @required this.uid,
//     this.alert = true,
//   }) : super(key: key);

//   @override
//   _KultChoiceButtonState createState() => _KultChoiceButtonState();
// }

// class _KultChoiceButtonState extends State<KultChoiceButton> {
//   bool switcher = true;

//   @override
//   void initState() {
//     super.initState();
//     switcher = widget.enabled;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final alert = Alert(
//       context: context,
//       style: alertStyle,
//       type: AlertType.info,
//       title: "Choix éffectué",
//       desc:
//           "${switcher ? "Tu es convié au culte" : "Tu ne participeras plus au culte"} ${widget.choice.msg}.",
//       content: SizedBox(width: 10),
//       buttons: [
//         DialogButton(
//           child: Text(
//             "Sois béni",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           onPressed: () => Navigator.pop(context),
//           color: Color(0xFF0A8B9C),
//           radius: BorderRadius.circular(10.0),
//         ),
//       ],
//     );
//     return Container(
//       margin: widget.margin ?? EdgeInsets.only(right: 10),
//       child: FlatButton(
//         padding: EdgeInsets.symmetric(
//           horizontal: 10,
//         ),
//         splashColor: switcher ? Colors.white54 : Colors.black54,
//         color: switcher ? Colors.black87 : Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         textColor: !switcher ? Colors.black87 : Colors.white,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Icon(
//               widget.iconData ?? Icons.add_alert,
//               size: size.width * 0.035,
//             ),
//             SizedBox(width: 10),
//             Text(
//               widget.choice.text,
//               style: TextStyle(fontSize: size.width * 0.035),
//             )
//           ],
//         ),
//         onPressed: switcher
//             ? () async {
//               final uuid =  await FireStoreChoiceSource.getUserUid;
//               print(uuid);
//                 if (await FireStoreChoiceSource().addOne(
//                   widget.choice,
//                   widget.uid ?? uuid,
//                 )) {
//                   if (widget.alert) alert.show();
//                   setState(() {
//                     switcher = false;
//                   });
//                 }
//               }
//             : () async {
//                 final check = await FireStoreChoiceSource().removeOne(
//                   widget.choice,
//                   widget.uid ?? await FireStoreChoiceSource.getUserUid,
//                 );
//                 print('checking ...');
//                 print(check);
//                 if (check) {
//                   if (widget.alert) alert.show();
//                   setState(() {
//                     switcher = true;
//                   });
//                 }
//               },
//       ),
//     );
//   }
// }
