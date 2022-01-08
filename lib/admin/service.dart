import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/admin/admin.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/services/services.dart';

class AdminService {
  const AdminService._();

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static final AdminController _controller = Get.find();

  // ---------------------- Firebase references ----------------------

  static final DocumentReference _adminCollection =
      _firebaseFirestore.collection(kAdminCollection).doc('admin');
  static final CollectionReference _pendingCollection = _firebaseFirestore
      .collection(kPendingCollection)
      .withConverter<FacultyModal>(
        fromFirestore: (snapshot, _) => FacultyModal.fromMap(snapshot.data()!),
        toFirestore: (facultyModal, _) => facultyModal.toMap(),
      );
  static final CollectionReference _facultyCollection = _firebaseFirestore
      .collection(kFacultyCollection)
      .withConverter<FacultyModal>(
        fromFirestore: (snapshot, _) => FacultyModal.fromMap(snapshot.data()!),
        toFirestore: (facultyModal, _) => facultyModal.toMap(),
      );

  static final CollectionReference _noticeCollection = _firebaseFirestore
      .collection(kNoticesCollection)
      .withConverter<NoticeModal>(
        fromFirestore: (snapshot, _) => NoticeModal.fromMap(snapshot.data()!),
        toFirestore: (noticeModal, _) => noticeModal.toMap(),
      );

  static final CollectionReference _eventCollection = _firebaseFirestore
      .collection(kEventsCollection)
      .withConverter<EventModal>(
        fromFirestore: (snapshot, _) => EventModal.fromMap(snapshot.data()!),
        toFirestore: (eventModal, _) => eventModal.toMap(),
      );

  // ---------------------- Streams ----------------------

  static final Stream<QuerySnapshot> pendingStream = _firebaseFirestore
      .collection(kPendingCollection)
      .where('userID', isNotEqualTo: '')
      .snapshots();

  static Future<dynamic> login(String id, String password) async {
    try {
      DialogService.showLoadingDialog(message: 'Logging in');

      DocumentSnapshot admin = await _adminCollection.get();

      Map<String, dynamic> adminData = admin.data() as Map<String, dynamic>;

      DialogService.closeDialog();

      if (id == adminData['id'] && password == adminData['password']) {
        _controller.error = '';
        _controller.showError = false;
        UserCredential? credential = await AuthenticationService.login(
            'admin@lkcengg.edu.in', 'admin123', true);
        if (credential != null) {
          _controller.logIn();
        } else {
          DialogService.showErrorDialog(message: 'Cannot login at the moment');
        }
      } else {
        _controller.error = 'Incorrect Admin id or password';
        _controller.showError = true;
      }
    } catch (e, st) {
      DialogService.closeDialog();
      log("Admin Login Error --> $e\n$st");
    }
  }

  static Future<dynamic> acceptFaculty(FacultyModal facultyModal) async {
    try {
      DialogService.showLoadingDialog(message: 'Accepting');

      final DocumentReference facultyReference =
          await _facultyCollection.add(facultyModal.copyWith(
        isVerified: true,
      ));

      /// Checking if the data is added to [faculty] collection
      final DocumentSnapshot facultySnapshot =
          await _facultyCollection.doc(facultyReference.id).get();

      final FacultyModal faculty = facultySnapshot.data() as FacultyModal;

      if (facultyModal.userID == faculty.userID) {
        await _facultyCollection.doc(facultyReference.id).set(
              facultyModal.copyWith(
                isVerified: true,
                facultyID: facultyReference.id,
              ),
            );
        await _pendingCollection.doc(facultyModal.facultyID).delete();

        DialogService.showToast('Faculty Verified');
      } else {
        DialogService.showSnackBar(
          'Error',
          'Faculty was not accepted due to some error',
          dialogType: DialogType.error,
        );
      }
    } catch (e, st) {
      log("Accepting Faculty Error --> $e\n$st");
    } finally {
      DialogService.closeDialog();
    }
  }

  static Future<dynamic> rejectingFaculty(FacultyModal facultyModal) async {
    try {
      DialogService.showLoadingDialog(message: 'Rejecting');

      await _pendingCollection.doc(facultyModal.facultyID).delete();

      DialogService.showToast('Faculty Rejected');
    } catch (e, st) {
      log("Rejecting Faculty Error --> $e\n$st");
    } finally {
      DialogService.closeDialog();
    }
  }

  static Future<bool> addNotice(NoticeModal noticeModal) async {
    try {
      DialogService.showLoadingDialog(message: 'Adding Notice');

      DocumentReference noticeReference =
          await _noticeCollection.add(noticeModal);

      await noticeReference
          .set(noticeModal.copyWith(noticeID: noticeReference.id));

      DialogService.closeDialog();
      return true;
    } catch (e, st) {
      DialogService.closeDialog();
      log("Add Notice Error --> $e\n$st");
      return false;
    }
  }

  static Future<bool> createNotice(EventModal eventModal) async {
    try {
      DialogService.showLoadingDialog(message: 'Creating Event');

      DocumentReference eventReference = await _eventCollection.add(eventModal);

      await eventReference.set(eventModal.copyWith(evendID: eventReference.id));

      DialogService.closeDialog();
      return true;
    } catch (e, st) {
      DialogService.closeDialog();
      log("Create Event Error --> $e\n$st");
      return false;
    }
  }
}
