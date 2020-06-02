// import 'package:flutter/material.dart';
// import 'package:kult/data/datasources/firebase/choice.dart';
// import 'package:kult/data/datasources/firebase/member.dart';
// import 'package:kult/data/models/choice.dart';
// import 'package:kult/data/models/member.dart';
// import 'package:kult/domain/entities/choice_list.dart';
// import 'package:kult/ui/contrats/screen_routing.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'kult_choice_button.dart';


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

// class KultChoiceButtonOther extends StatefulWidget with ScreenRouting {
//   final IconData iconData;
//   final ChoiceList choice;
//   final EdgeInsetsGeometry margin;
//   final bool enabled, alert;
//   final bool Function() ableToRegister;
//   final MemberModel model;

//   const KultChoiceButtonOther({
//     Key key,
//     this.iconData,
//     this.margin,
//     @required this.choice,
//     this.enabled = true,
//     this.alert = true,
//     @required this.model, this.ableToRegister,
//   }) : super(key: key);

//   @override
//   _KultChoiceButtonOtherState createState() => _KultChoiceButtonOtherState();
// }

// class _KultChoiceButtonOtherState extends State<KultChoiceButtonOther> {
//   bool switcher = true;

//   @override
//   void initState() {
//     super.initState();
//     switcher = widget.enabled;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final alertMsg = StringBuffer();
//     final model = widget.model;
//     alertMsg.write(model.lastName ?? model.firstNames ?? "Inconnu");
//     alertMsg.write(' ');
//     alertMsg.write(switcher ? "sera convié au culte" : "ne participeras plus au culte");
//     alertMsg.write(' ');
//     alertMsg.write(widget.choice.msg);
//     alertMsg.write('.');
//     final alert = Alert(
//       context: context,
//       style: alertStyle,
//       type: AlertType.info,
//       title: "Choix éffectué",
//       desc: alertMsg.toString(),
//       content: SizedBox(width: 10),
//       buttons: [
//         DialogButton(
//           child: Text(
//             "OK",
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
//         onPressed:  switcher
//             ? () async {
//                 if (widget.ableToRegister() && widget.model != null &&
//                     await FireStoreChoiceSource().update(
//                       widget.model,
//                       widget.choice,
//                     )) {
//                   if (widget.alert) alert.show();
//                   setState(() {
//                     switcher = false;
//                   });
//                 }
//               }
//             : () async {
//                 if (widget.ableToRegister() && widget.model != null &&
//                     await FireStoreChoiceSource().removeOne(
//                       widget.choice,
//                       widget.model.uid,
//                     )) {
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
