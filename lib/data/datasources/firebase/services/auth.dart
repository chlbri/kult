import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kult/ui/contrats/phone_dialog.dart';

class PhoneResult {
  final FirebaseUser user;
  final String verificationId;

  const PhoneResult({@required this.verificationId, @required this.user});
}

class FirebaseAuthService {
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

  Future<FirebaseUser> get currentUser => _auth.currentUser();
  Future<String> get currentUid =>
      currentUser.then((val) => val.uid).catchError((_) => null);

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
  Future<String> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return _auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((val) => val.user.uid)
        .catchError((error) {
      print(error.toString());
      return null;
    });
  }

  ///Se connecter avec email et mot de passe
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      return _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          print(value.user.uid);
          return true;
        },
      ).catchError(
        (_) => false,
      );
    } catch (e) {
      print(e);
      return false;
    } finally {
      print('');
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

  Future<bool> resetPassword(String email) async {
    try {
      return await _auth
          .sendPasswordResetEmail(email: email)
          .then((value) => true)
          .catchError(() => false);
    } catch (e) {
      print('Error $e');
      return false;
    }
  }
}
