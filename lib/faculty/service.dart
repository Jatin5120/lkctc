import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';
import 'package:lkctc_student_app/routes/faculty_routes.dart';

import '../constants/constants.dart';
import '../modals/modals.dart';
import '../services/services.dart';

abstract class FacultyService {
  const FacultyService._();

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static final FacultyController _facultyController = Get.find();

  // ---------------------- Firebase references ----------------------

  static final CollectionReference<FacultyModal> _pendingCollection =
      _firebaseFirestore
          .collection(kPendingCollection)
          .withConverter<FacultyModal>(
            fromFirestore: (snapshot, _) =>
                FacultyModal.fromMap(snapshot.data()!),
            toFirestore: (facultyModal, _) => facultyModal.toMap(),
          );

  static final CollectionReference<FacultyModal> _facultyCollection =
      _firebaseFirestore
          .collection(kFacultyCollection)
          .withConverter<FacultyModal>(
            fromFirestore: (snapshot, _) =>
                FacultyModal.fromMap(snapshot.data()!),
            toFirestore: (facultyModal, _) => facultyModal.toMap(),
          );

  static final CollectionReference<ClassModal> _classCollection =
      _firebaseFirestore.collection(kClassCollection).withConverter<ClassModal>(
            fromFirestore: (snapshot, _) =>
                ClassModal.fromMap(snapshot.data()!),
            toFirestore: (classModal, _) => classModal.toMap(),
          );

  static final CollectionReference<SubjectModal> _subjectCollection =
      _firebaseFirestore
          .collection(kSubjectCollection)
          .withConverter<SubjectModal>(
            fromFirestore: (snapshot, _) =>
                SubjectModal.fromMap(snapshot.data()!),
            toFirestore: (subjectModal, _) => subjectModal.toMap(),
          );

  // ---------------------- Streams ----------------------

  static final Stream<QuerySnapshot<FacultyModal>> facultyStream =
      _facultyCollection
          .where('userID', isEqualTo: _facultyController.facultyUserID)
          .snapshots();

  static final Stream<QuerySnapshot<FacultyModal>> allFacultyStream =
      _facultyCollection.snapshots();

  static final Stream<DocumentSnapshot<ClassModal>> classStream =
      _classCollection.doc(_facultyController.faculty.classID).snapshots();

  // ---------------------- Get Methods ----------------------

  static Stream<DocumentSnapshot<SubjectModal>> getSubject(String subjectID) =>
      _subjectCollection.doc(subjectID).get().asStream();

  // ---------------------- Methods ----------------------

  static Future<dynamic> login(String email, String password) async {
    try {
      DialogService.showLoadingDialog(message: 'Logging in');

      UserCredential? userCredential =
          await AuthenticationService.login(email, password);

      if (userCredential == null) {
        DialogService.closeDialog();
        DialogService.showErrorDialog(
          title: 'Error Signing in',
          message:
              'Invalid Email or Password. Kindly check and try again later',
        );
        return;
      }

      QuerySnapshot faculty = await _pendingCollection
          .where('userID', isEqualTo: userCredential.user!.uid)
          .get();

      if (faculty.docs.isEmpty) {
        faculty = await _facultyCollection
            .where('userID', isEqualTo: userCredential.user!.uid)
            .get();
        _facultyController.isLoggedIn = true;
        _facultyController.faculty = faculty.docs.first.data() as FacultyModal;
      } else {
        Get.offAllNamed(FacultyRoutes.notVerified);
      }

      DialogService.closeDialog();
    } catch (e, st) {
      DialogService.closeDialog();
      DialogService.showSnackBar(
        'Unknown Error',
        'An unknown error occured while registering, try again after some time',
      );
      log("Login faculty Error --> ${e.toString()}\n$st");
    }
  }

  static Future<bool> registerFaculty(FacultyModal facultyModal) async {
    try {
      DialogService.showLoadingDialog(message: "Registering faculty");

      final DocumentReference pendingReference =
          await _pendingCollection.add(facultyModal);

      FacultyModal faculty = facultyModal.copyWith(
        facultyID: pendingReference.id,
      );

      _pendingCollection.doc(pendingReference.id).set(faculty);

      await AuthenticationService.register(
        facultyModal.email,
        facultyModal.password,
      );

      faculty = faculty.copyWith(userID: _firebaseAuth.currentUser!.uid);

      await _pendingCollection.doc(pendingReference.id).set(faculty);

      await _firebaseAuth.currentUser!.updateDisplayName(facultyModal.name);

      return true;
    } catch (e, st) {
      DialogService.showSnackBar(
        'Unknown Error',
        'An unknown error occured while registering, try again after some time',
      );
      log("Add faculty Error --> ${e.toString()}\n$st");
      return false;
    } finally {
      DialogService.closeDialog();
    }
  }

  static Future<dynamic> createClass(ClassModal classModal) async {
    try {
      DialogService.showLoadingDialog(message: 'Creating class');

      final DocumentReference classReference =
          await _classCollection.add(classModal);

      final Map<String, dynamic> classIDMap = {'classID': classReference.id};

      await classReference.update(classIDMap);

      await _facultyCollection.doc(_facultyController.faculty.facultyID).update(
            classIDMap
              ..addAll(
                {
                  'classes': [classReference.id]
                },
              ),
          );

      return true;
    } catch (e, st) {
      DialogService.showSnackBar(
        'Error Creating class',
        'An unknown error occured while creating class, try again after some time',
      );
      log("Creating class Error --> $e\n$st");
      return false;
    } finally {
      DialogService.closeDialog();
    }
  }

  static Future<bool> createSubject({
    required SubjectModal subjectModal,
    required ClassModal classModal,
  }) async {
    try {
      DialogService.showLoadingDialog(message: 'Adding subject');

      /// Adding/Updating data in [Subject] collections
      final DocumentReference<SubjectModal> subjectReference =
          await _subjectCollection.add(subjectModal);

      final Map<String, dynamic> subjectIDMap = {
        'subjectID': subjectReference.id
      };

      await subjectReference.update(subjectIDMap);

      /// Adding/Updating data in [Class] collections
      final DocumentReference<ClassModal> classReference =
          _classCollection.doc(classModal.classID);

      await classReference.update(
        {
          'faculties': [
            ...classModal.faculties,
            subjectModal.facultyID,
          ],
          'subjects': [
            ...classModal.subjects,
            subjectReference.id,
          ]
        },
      );

      /// Adding/Updating data in [Faculty] collections
      final DocumentReference<FacultyModal> facultyReference =
          _facultyCollection.doc(subjectModal.facultyID);

      final DocumentSnapshot<FacultyModal> facultySnapshot =
          await facultyReference.get();

      await facultyReference.update(
        {
          'classes': [
            ...facultySnapshot.data()!.classes,
            classModal.classID,
          ],
          'subjects': [
            ...facultySnapshot.data()!.subjects,
            subjectReference.id,
          ]
        },
      );

      return true;
    } catch (e, st) {
      DialogService.showSnackBar(
        'Subject not Added',
        'An unknown error occured while creating subject, try again after some time',
      );
      log("Creating subject Error --> $e\n$st");
      return false;
    } finally {
      DialogService.closeDialog();
    }
  }
}
