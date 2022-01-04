import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/services/services.dart';

abstract class FacultyService {
  const FacultyService._();

  static Future<dynamic> addFaculty(FacultyModal facultyModal) async {
    try {
      DialogService.showLoadingDialog(message: "Registering faculty");

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: facultyModal.email,
        password: facultyModal.password,
      );

      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(facultyModal.name);

      DialogService.closeDialog();
    } on FirebaseAuthException catch (e) {
      DialogService.closeDialog();

      if (e.code == 'weak-password') {
        DialogService.showErrorDialog(
          title: "Error Registering",
          message: "Password you're trying to create is weak, try stronger.",
        );
      } else if (e.code == 'email-already-in-use') {
        DialogService.showErrorDialog(
          title: "Error Registering",
          message:
              "An account already exists with the email ${facultyModal.email}. Kindly check and try again",
        );
      } else if (e.code == 'invalid-email') {
        DialogService.showErrorDialog(
          title: "Error Registering",
          message:
              "The email ${facultyModal.email} is invalid. Kindly check and try again",
        );
      }
    } catch (e) {
      DialogService.showSnackBar(
        'Unknown Error',
        'An unknown error occured while registering, try again after some time',
      );
      log("Add faculty Error --> ${e.toString()}");
    }
  }
}
