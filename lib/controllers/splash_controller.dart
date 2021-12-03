import 'package:get/get.dart';

class SplashController extends GetxController {
  final RxDouble _bottom = 300.0.obs;
  final RxBool _animationStarted = false.obs;
  final RxDouble _nameOpacity = 0.0.obs;
  final RxDouble _logoOpacity = 0.0.obs;
  final RxDouble _logoPosition = 0.0.obs;
  final RxDouble _fontSize = 40.0.obs;

  double get bottom => _bottom.value;
  bool get animationStarted => _animationStarted.value;
  double get nameOpacity => _nameOpacity.value;
  double get logoOpacity => _logoOpacity.value;
  double get logoPosition => _logoPosition.value;
  double get fontSize => _fontSize.value;

  set bottom(double bottom) => _bottom.value = bottom;
  set animationStarted(bool animationStarted) =>
      _animationStarted.value = animationStarted;
  set nameOpacity(double nameOpacity) => _nameOpacity.value = nameOpacity;
  set logoOpacity(double logoOpacity) => _logoOpacity.value = logoOpacity;
  set logoPosition(double logoPosition) => _logoPosition.value = logoPosition;
  set fontSize(double fontSize) => _fontSize.value = fontSize;
}
