import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sura_online_shopping_admin/commons/adim_home/screen/home.dart';
import 'package:sura_online_shopping_admin/feature_authentication/view/otp_screen.dart';

class AuthenticationWithFirebase {
  AuthenticationWithFirebase({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;
  int? resendToken;
  late String verificationId;

  Future<String> veryfiyPhoneNumber(String phoneNumber) async {
    String message = 'VerficationSucess';
    await _firebaseAuth.verifyPhoneNumber(
        forceResendingToken: resendToken,
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          debugPrint(
              'inside the verfification Completed callback function=======================================>');
          await _firebaseAuth.signInWithCredential(credential);
          message = 'VerficationSucess';
        },
        verificationFailed: (e) {
          debugPrint(e.message);
          throw SigninWithPhoneNumberFailure(e.code);
        },
        codeSent: (verificationId, resendToken) async {
          this.resendToken = resendToken;
          this.verificationId = verificationId;
          message = 'VerficationSucess';
          debugPrint(
              'inside the verfification Completed callback function=======================================>');
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return const OtpScreen();
          // }));
        },
        codeAutoRetrievalTimeout: (_) {});

    return message;
  }

  Future<void> signInwithCredential(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await _firebaseAuth.signInWithCredential(credential);
  }

  bool isUserIsLoggedIn() {
    return _firebaseAuth.currentUser == null ? false : true;
  }

  String? loggedInUser() {
    return _firebaseAuth.currentUser == null
        ? null
        : _firebaseAuth.currentUser!.uid;
  }

  Future<void> logout() async {
    try {
      _firebaseAuth.signOut();
    } catch (_) {
      SignOutFailure();
    }
  }
}

class SigninWithPhoneNumberFailure implements Exception {
  String massage = 'unknown error occured';
  SigninWithPhoneNumberFailure._(this.massage);
  SigninWithPhoneNumberFailure.def();
  factory SigninWithPhoneNumberFailure(String fromCode) {
    switch (fromCode) {
      case 'invalid phone Number':
        return SigninWithPhoneNumberFailure._('invalid phone Number');
      default:
        return SigninWithPhoneNumberFailure.def();
    }
  }
}

class SignOutFailure implements Exception {
  String message = 'unknown error occured while logging out';
  SignOutFailure();
}
