import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'faculty.dart';

abstract class FacultyService {
  const FacultyService._();

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  // ---------------------- Firebase references ----------------------

  static final CollectionReference _pendingCollection = _firebaseFirestore
      .collection(kPendingCollection)
      .withConverter<FacultyModal>(
        fromFirestore: (snapshot, _) => FacultyModal.fromMap(snapshot.data()!),
        toFirestore: (facultyModal, _) => facultyModal.toMap(),
      );

  static Future<dynamic> login(String email, String password) async {
    try {
      DialogService.showLoadingDialog(message: 'Logging in');

      UserCredential? userCredential =
          await AuthenticationController.loginUser(email, password);

      // print(userCredential);

      QuerySnapshot faculty = await _pendingCollection
          .where('userID', isEqualTo: userCredential!.user!.uid)
          .get();

      print(faculty.docs.first.data());

      DialogService.closeDialog();
    } catch (e, st) {
      DialogService.closeDialog();
      DialogService.showSnackBar(
        'Unknown Error',
        'An unknown error occured while registering, try again after some time',
      );
      log("Add faculty Error --> ${e.toString()}\n$st");
    }
  }

  static Future<dynamic> addFaculty(FacultyModal facultyModal) async {
    try {
      DialogService.showLoadingDialog(message: "Registering faculty");

      DocumentReference pendingReference =
          await _pendingCollection.add(facultyModal);

      FacultyModal faculty = facultyModal.copyWith(
        facultyID: pendingReference.id,
        // userID: _firebaseAuth.currentUser!.uid,
      );

      _pendingCollection.doc(pendingReference.id).set(faculty);

      await AuthenticationController.registerUser(
        facultyModal.email,
        facultyModal.password,
      );

      faculty = faculty.copyWith(userID: _firebaseAuth.currentUser!.uid);

      _pendingCollection.doc(pendingReference.id).set(faculty);

      await _firebaseAuth.currentUser!.updateDisplayName(facultyModal.name);

      DialogService.closeDialog();
    } catch (e, st) {
      DialogService.closeDialog();
      DialogService.showSnackBar(
        'Unknown Error',
        'An unknown error occured while registering, try again after some time',
      );
      log("Add faculty Error --> ${e.toString()}\n$st");
    }
  }
}
