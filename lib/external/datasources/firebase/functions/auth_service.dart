import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kult/external/ui/contrats/phone_dialog.dart';

class PhoneResult {
  final FirebaseUser user;
  final String verificationId;

  const PhoneResult({@required this.verificationId, @required this.user});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///e connecter anonymement
  Future signInAnon() async {
    try {
      final result = await _auth.signInAnonymously();
      print(result.user.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///
  Future<PhoneResult> signInWithNumber({
    @required BuildContext context,
    @required String phoneNumber,
    int forceResendingToken,
    PhoneVerificationFailed verificationFailed,
  }) async {
    FirebaseUser user;
    String verificationId;
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(minutes: 1),
      verificationCompleted: (credentials) async {
        final result = await _auth.signInWithCredential(credentials);
        user = result.user;
      },
      forceResendingToken: forceResendingToken,
      verificationFailed: verificationFailed ?? (exception) => print(exception),
      codeSent: (verId, [forceResendingToken]) {
        verificationId = verId;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => PhoneDialog(
            auth: _auth,
            setUser: (value) => user = value,
            verId: verId,
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        //Starts the phone number verification process for the given phone number.
        //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
      },
    );
    return PhoneResult(
      verificationId: verificationId,
      user: user,
    );
  }

  ///S'inscrire avec email et mot de passe
  Future sinUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  ///Se connecter avec email et mot de passe
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  ///Se déconnecter
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
