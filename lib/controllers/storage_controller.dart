import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final String _userTypeKey = 'userType';
  final String _isUserLoggedInKey = 'isUserLoggedIn';
  final String _facultyUserIDKey = "FacultyUserID";

  late String userType;
  late bool isUserLoggedIn;
  late String facultyUserID;

  final GetStorage _storage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    _readUserType();
    _readUserLoggedIn();
    _readFacultyUserID();
  }

  void _readUserLoggedIn() {
    isUserLoggedIn = _storage.read<bool>(_isUserLoggedInKey) ?? false;
  }

  Future<void> writeUserLoggedIn(bool loggedIn) async {
    await _storage.write(_isUserLoggedInKey, loggedIn);
    _readUserLoggedIn();
  }

  void _readUserType() {
    userType = _storage.read<String>(_userTypeKey) ?? '';
  }

  Future<void> writeUserType(String type) async {
    await _storage.write(_userTypeKey, type);
    _readUserType();
  }

  void _readFacultyUserID() {
    facultyUserID = _storage.read<String>(_facultyUserIDKey) ?? '';
  }

  Future<void> writeFacultyUserID(String id) async {
    await _storage.write(_facultyUserIDKey, id);
    _readFacultyUserID();
  }
}
