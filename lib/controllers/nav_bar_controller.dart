import 'package:get/get.dart';

class NavBarController extends GetxController {
  final RxInt _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(int selectedIndex) => _selectedIndex.value = selectedIndex;
}
