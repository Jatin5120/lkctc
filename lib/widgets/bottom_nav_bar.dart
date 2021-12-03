import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../constants/constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key, required this.navBarItems}) : super(key: key);

  final List<BottomNavBarItem> navBarItems;

  static NavBarController navBarController = Get.find();
  static const double _navBarHeight = 64;
  static const double _navBarMargin = 8;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double containerWidth = size.width / 4 - 4;
    return Obx(
      () => SizedBox(
        height: _navBarHeight,
        width: size.width,
        child: Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          margin: EdgeInsets.zero,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: kAnimationDuration,
                curve: Curves.easeInOutBack,
                left: _navBarMargin +
                    navBarController.selectedIndex * containerWidth,
                top: _navBarMargin,
                height: _navBarHeight - 2 * _navBarMargin,
                child: Container(
                  width: containerWidth,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(_navBarMargin),
                child: Row(
                  children: [
                    for (int i = 0; i < navBarItems.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          if (navBarItems[i].onTap != null) {
                            navBarItems[i].onTap!();
                          }
                          navBarController.selectedIndex = i;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: containerWidth,
                          child: Icon(
                            navBarItems[i].icon,
                            color: navBarController.selectedIndex == i
                                ? kWhiteColor
                                : kHintTextColor,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarItem {
  final IconData icon;
  final VoidCallback? onTap;

  BottomNavBarItem({required this.icon, this.onTap});
}
