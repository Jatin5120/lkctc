import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/constants.dart';

class StorageController extends GetxController {
  final String _userTypeKey = 'userType';
  final String _isUserLoggedInKey = 'isUserLoggedIn';

  late UserType userType;
  late bool isUserLoggedIn;

  final GetStorage _storage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    userType = _readUserType();
    isUserLoggedIn = _readUserLoggedIn();
  }

  bool _readUserLoggedIn() => _storage.read<bool>(_isUserLoggedInKey) ?? false;

  Future<void> writeUserLoggedIn(bool loggedIn) async =>
      await _storage.write(_isUserLoggedInKey, loggedIn);

  UserType _readUserType() =>
      _storage.read<UserType>(_userTypeKey) ?? UserType.student;

  Future<void> writeUserType(UserType type) async =>
      await _storage.write(_userTypeKey, type);
}
