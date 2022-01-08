import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../constants/constants.dart';
import '../services/dialog_service.dart';
import '../services/services.dart';

class DocumentService {
  const DocumentService._();

  static Future<File?> getDocument() async {
    DialogService.showLoadingDialog();

    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    DialogService.closeDialog();

    if (result == null) {
      DialogService.showSnackBar(
        'No file found',
        'No file has been selected',
        dialogType: DialogType.error,
      );
      return null;
    }

    if (result.count > 1) {
      DialogService.showSnackBar(
        'Multiple files',
        'Kidnly, select only one file',
        dialogType: DialogType.warning,
      );
      return null;
    }

    final PlatformFile platformFile = result.files.first;

    final File file = File(platformFile.path!);

    return file;
    // FirebaseService.uploadFile(
    //   file: file,
    //   name: name,
    //   fileType: platformFile.extension!,
    //   path: file.path,
    // );

    // print(path);
  }
}
