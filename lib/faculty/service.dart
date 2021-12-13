import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

abstract class FacultyService {
  const FacultyService._();

  Future<dynamic> addFaculty(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      log("Add faculty Error --> ${e.toString()}");
    }
  }
}
