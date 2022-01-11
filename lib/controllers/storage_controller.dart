import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final String _userTypeKey = 'userType';
  final String _isUserLoggedInKey = 'isUserLoggedIn';
  final String _facultyIDKey = "facultyID";

  late String userType;
  late bool isUserLoggedIn;
  late String facultyID;

  final GetStorage _storage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    _readUserType();
    _readUserLoggedIn();
    _readFacultyID();
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

  void _readFacultyID() {
    facultyID = _storage.read<String>(_facultyIDKey) ?? '';
  }

  Future<void> writefacultyID(String id) async {
    await _storage.write(_facultyIDKey, id);
    _readFacultyID();
  }
}
