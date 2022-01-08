import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

import 'services.dart';

class AuthenticationService {
  const AuthenticationService._();

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<UserCredential?> login(String email, String password,
      [bool isAdmin = false]) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      DialogService.closeDialog();

      switch (e.code) {
        case 'invalid-email':
          DialogService.showErrorDialog(
            title: "Error Login",
            message: "The email $email is invalid. Kindly check and try again",
          );
          break;
        case 'user-disabled':
          DialogService.showErrorDialog(
            title: "Error Login",
            message: "Your account has been disabled. Kindly contact admin",
          );
          break;
        case 'user-not-found':
          if (isAdmin) {
            register(email, password);
          } else {
            DialogService.showErrorDialog(
              title: "Error Login",
              message: "No Account found. Register first if you haven't",
            );
          }
          break;
        case 'wrong-password':
          DialogService.showErrorDialog(
            title: "Error Login",
            message: "Wrong password. Kindly check and try again",
          );
          break;
      }
    } catch (e, st) {
      DialogService.closeDialog();
      DialogService.showSnackBar(
        'Unknown Error',
        'An unknown error occured while login, try again after some time',
      );
      log("Login User Error --> ${e.toString()}\n$st");
    }
  }

  static Future<UserCredential?> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      DialogService.closeDialog();

      switch (e.code) {
        case 'weak-password':
          DialogService.showErrorDialog(
            title: "Error Registering",
            message: "Password you're trying to create is weak, try stronger.",
          );
          break;
        case 'email-already-in-use':
          DialogService.showErrorDialog(
            title: "Error Registering",
            message:
                "An account already exists with the email $email. Kindly check and try again",
          );
          break;
        case 'invalid-email':
          DialogService.showErrorDialog(
            title: "Error Registering",
            message: "The email $email is invalid. Kindly check and try again",
          );
          break;
      }
    } catch (e, st) {
      DialogService.closeDialog();
      DialogService.showSnackBar(
        'Unknown Error',
        'An unknown error occured while registering, try again after some time',
      );
      log("Register User Error --> ${e.toString()}\n$st");
    }
  }
}
