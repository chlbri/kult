import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneDialog extends StatelessWidget {
  PhoneDialog({
    Key key,
    this.verId,
    this.auth,
    this.setUser,
    this.textStyle,
  }) : super(key: key);

  final FirebaseAuth auth;
  final TextStyle textStyle;
  final String verId;
  final void Function(FirebaseUser) setUser;

  @override
  Widget build(BuildContext context) {
    String code;
    return AlertDialog(
      title: Text("Give the code?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <StatefulWidget>[
          TextField(
            onChanged: (value) => code = value,
            style: textStyle,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(12.0),
          ),
          child: Text("Confirmez"),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: () async {
            final credential = PhoneAuthProvider.getCredential(
              verificationId: verId,
              smsCode: code.trim(),
            );
            final result = await auth.signInWithCredential(credential);
            setUser(result.user);
          },
        )
      ],
    );
  }
}
