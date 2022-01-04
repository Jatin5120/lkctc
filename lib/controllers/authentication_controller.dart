import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/routes/routes.dart';
import 'package:lkctc_student_app/services/services.dart';

class AuthenticationController extends GetxController {
  final RxBool _isLoggedIn = false.obs;
  final RxBool _isLoaded = false.obs;
  final RxInt _selectedIndex = 5.obs;

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  onReady() {
    super.onReady();
    ever(_isLoaded, _handleLoading);
  }

  _handleLoading(bool value) {
    if (value) {
      Get.offAllNamed(CommonRoutes.auth);
    } else {
      Get.offAllNamed(CommonRoutes.splash);
    }
  }

  bool get isLoggedIn => _isLoggedIn.value;
  bool get isLoaded => _isLoaded.value;
  int get selectedIndex => _selectedIndex.value;

  set isLoggedIn(bool isLoggedIn) => _isLoggedIn.value = isLoggedIn;
  set isLoaded(bool isLoaded) => _isLoaded.value = isLoaded;
  set selectedIndex(int selectedIndex) => _selectedIndex.value = selectedIndex;

  static Future<UserCredential?> loginUser(
      String email, String password) async {
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
          DialogService.showErrorDialog(
            title: "Error Login",
            message: "Your account has been disabled. Kindly contact admin",
          );
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

  static Future<UserCredential?> registerUser(
      String email, String password) async {
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
