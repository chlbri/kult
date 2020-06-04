import 'package:flutter/material.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/ui/contrats/screen_routing.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: const TextStyle(fontWeight: FontWeight.bold),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.brown[200],
  ),
);

class CheckboxKult extends StatelessWidget with ScreenRouting {
  final EdgeInsetsGeometry margin;
  final bool enabled;
  final Widget first, second;

  const CheckboxKult({
    Key key,
    this.margin,
    this.enabled,
    this.first,
    this.second,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(right: 10),
      child: enabled ? first : second,
    );
  }
}
