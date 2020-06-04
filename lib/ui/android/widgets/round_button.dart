import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Color(0xFFBA7D40), // button color
        child: InkWell(
          splashColor: Colors.white60, // inkwell color
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.person_add,
              color: Colors.white,
              size: 50,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}