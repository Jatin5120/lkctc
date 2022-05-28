import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constants.dart';
import '../controllers/controllers.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  static final ThemeController _themeController = Get.find();
  static final SplashController _splashController = Get.find();
  static final AuthenticationController _authenticationController = Get.find();

  late AnimationController _animationController;
  late Animation<double> _nameAnimation;

  initializeAnimation(duration) async {
    final Size size = MediaQuery.of(context).size;

    _animationController =
        AnimationController(vsync: this, duration: kSplashDuration);

    _nameAnimation = Tween<double>(begin: 40, end: 20).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastLinearToSlowEaseIn)
        ..addListener(() {
          _splashController.fontSize = _nameAnimation.value;
        }),
    );

    _splashController.bottom = size.height.fiftyPercent;
    _animationController.forward();

    _splashController.nameOpacity = 1;
    _splashController.animationStarted = true;

    await Future.delayed(kDelayDuration);

    _splashController.bottom = size.height.fivePercent;
    _splashController.logoOpacity = 1;
    _splashController.logoPosition = size.width.thirtyPercent;

    await Future.delayed(kSplashDuration);
    _authenticationController.isLoaded = true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(initializeAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _themeController.isDarkMode ? kSplashColorDark : kSplashColorLight,
      body: SafeArea(
        child: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                duration: kSplashDuration,
                curve: Curves.fastLinearToSlowEaseIn,
                bottom: _splashController.bottom,
                child: AnimatedOpacity(
                  duration: kSplashDuration,
                  opacity: _splashController.nameOpacity,
                  child: Text(
                    kAppName,
                    style: TextStyle(
                      color: _themeController.isDarkMode
                          ? kWhiteColor
                          : kPrimaryColor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      fontSize: _splashController.fontSize,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: kSplashDuration,
                left: _splashController.logoPosition,
                right: _splashController.logoPosition,
                curve: Curves.fastLinearToSlowEaseIn,
                child: AnimatedOpacity(
                  opacity: _splashController.logoOpacity,
                  duration: kSplashDuration,
                  child: Image.asset('assets/logo/lkctc.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
