import 'package:flutter/material.dart';

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
    final size = MediaQuery.of(context).size;
    return Container(
      margin: margin ?? EdgeInsets.only(right: 10),
      child: FlatButton(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            iconData ??
                Icon(
                  Icons.add_alert,
                  size: size.width * 0.035,
                ),
            SizedBox(width: 10),
            Text(
              data,
              style: TextStyle(fontSize: size.width * 0.035),
            )
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
