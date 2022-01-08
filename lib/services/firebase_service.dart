import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/services/dialog_service.dart';

class FirebaseService {
  const FirebaseService._();

  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  /// This method will upload the file and will return the download url from firestore
  static Future<String?> uploadFile({
    required File file,
    required String name,
    required String fileType,
    required String path,
  }) async {
    try {
      DialogService.showLoadingDialog(message: 'Uploading image');

      final String fileName = "$name.$fileType";

      final Reference reference =
          _firebaseStorage.ref().child(path).child('/$fileName');

      final metaData = SettableMetadata(
        contentType: 'file/$fileType',
      );

      reference.putFile(file, metaData);

      final String link = await getDownloadUrl(fileName, path);

      DialogService.closeDialog();

      return link;
    } on FirebaseException catch (e) {
      log("Image Upload Firebase Error --> $e");
    } catch (e, st) {
      DialogService.showSnackBar(
        'Unknown Error',
        'Some unknown error occured while uploading image.',
        dialogType: DialogType.warning,
      );
      log("Image Upload Error --> $e\n$st");
    }
  }

  static Future<String> getDownloadUrl(String name, String path) async {
    ListResult list = await _firebaseStorage.ref().child(path).listAll();

    if (list.items.last.name == name) {
      return await _firebaseStorage
          .ref()
          .child(path)
          .child("/$name")
          .getDownloadURL();
    } else {
      return await getDownloadUrl(name, path);
    }
  }
}
