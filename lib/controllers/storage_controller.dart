import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final String _userTypeKey = 'userType';
  final String _isUserLoggedInKey = 'isUserLoggedIn';

  late String userType;
  late bool isUserLoggedIn;

  final GetStorage _storage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    _readUserType();
    _readUserLoggedIn();
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
}
