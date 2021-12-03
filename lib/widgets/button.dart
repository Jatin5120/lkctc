import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';

class Button extends StatelessWidget {
  ///It will return a Primary button, from `ElevatedButton` class
  ///
  ///
  ///If you want to make the button bigger in size pass in the optional parameter
  ///```dart
  ///ButtonSize buttonSize;
  ///```
  ///`ButtonSize` is an `enum` which has the following values
  ///[ButtonSize.small], [ButtonSize.medium], and [ButtonSize.large]
  ///
  ///[ButtonSize] deafults to [ButtonSize.small]
  ///
  ///Other Optional parameters are
  ///```dart
  ///Color buttonColor;
  ///Color labelColor;
  ///```
  ///
  ///
  ///Other two constructors are -
  ///
  ///* ```dart
  ///Button.secondary() // returns a Secondary Button
  ///```
  ///* ```dart
  ///Button.outlined()  // returns an Outlined Button
  ///```
  ///
  const Button({
    Key? key,
    required this.label,
    required this.onTap,
    this.buttonColor,
    this.labelColor,
    this.buttonSize = ButtonSize.small,
  })  : buttonType = ButtonType.primary,
        super(key: key);

  ///It will return a Secondary button, from `ElevatedButton` class
  ///
  ///
  ///If you want to make the button bigger in size pass in the optional parameter
  ///```dart
  ///ButtonSize buttonSize;
  ///```
  ///`ButtonSize` is an `enum` which has the following values
  ///[ButtonSize.small], [ButtonSize.medium], and [ButtonSize.large]
  ///
  ///[ButtonSize] deafults to [ButtonSize.small]
  ///
  ///Other Optional parameters are
  ///```dart
  ///Color buttonColor;
  ///Color labelColor;
  ///```
  ///
  ///
  ///Other two constructors are -
  ///
  ///* ```dart
  ///Button() // returns a Primary Button
  ///```
  ///* ```dart
  ///Button.outlined()  // returns an Outlined Button
  ///```
  ///
  const Button.secondary({
    Key? key,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.buttonColor,
    this.buttonSize = ButtonSize.small,
  })  : buttonType = ButtonType.secondary,
        super(key: key);

  ///It will return an Outlined button, from `OutlinedButton` class
  ///
  ///
  ///If you want to make the button bigger in size pass in the optional parameter
  ///```dart
  ///ButtonSize buttonSize;
  ///```
  ///`ButtonSize` is an `enum` which has the following values
  ///[ButtonSize.small], [ButtonSize.medium], and [ButtonSize.large]
  ///
  ///[ButtonSize] deafults to [ButtonSize.small]
  ///
  ///Other Optional parameters are
  ///```dart
  ///Color buttonColor;
  ///Color labelColor;
  ///```
  ///
  ///
  ///Other two constructors are -
  ///
  ///* ```dart
  ///Button() // returns a Primary Button
  ///```
  ///* ```dart
  ///Button.secondary()  // returns a Secondary Button
  ///```
  ///
  const Button.outlined({
    Key? key,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.buttonColor,
    this.buttonSize = ButtonSize.small,
  })  : buttonType = ButtonType.outlined,
        super(key: key);

  static ThemeController themeController = Get.find();

  final String label;
  final VoidCallback onTap;

  ///It takes an `enum` `ButtonSize`, which will determine the size of the button,
  ///
  ///The possible values of the `enum` are -
  ///* `ButtonSize.small`
  ///* `ButtonSize.medium`
  ///* `ButtonSize.large`
  ///
  ///It defaults to [ButtonSize.small]
  final ButtonSize buttonSize;
  final Color? buttonColor;
  final Color? labelColor;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double? width;
    late EdgeInsets padding;
    late double fontSize;
    late OutlinedBorder border;
    late double outlineWidth;

    ///Configuring value like [padding, width, fontSize, & border]
    ///base on enum [ButtonSize] which can have values [ButtonSize.small],
    ///[ButtonSize.medium, ButtonSize.large]
    ///
    ///Default to [ButtonSize.small]

    switch (buttonSize) {
      case ButtonSize.small:
        width = null;
        padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
        fontSize = 14;
        border = kSmallBorder;
        outlineWidth = 1;
        break;

      case ButtonSize.medium:
        width = size.width.thirtyFivePercent;
        padding = const EdgeInsets.symmetric(vertical: 12.0);
        fontSize = 16;
        border = kMediumBorder;
        outlineWidth = 1.5;
        break;

      case ButtonSize.large:
        width = double.maxFinite;
        padding = const EdgeInsets.symmetric(vertical: 16.0);
        fontSize = 20;
        border = kLargeBorder;
        outlineWidth = 2;
        break;

      default:
        width = null;
        padding = const EdgeInsets.symmetric(vertical: 8.0);
        fontSize = 14;
        border = kSmallBorder;
        outlineWidth = 1;
        break;
    }

    ///After configuring the values of [Button] based on [ButtonSize],
    ///[PrimaryButton, SecondaryButton or OutlinedButton] will be returned
    ///based on the property [ButtonType] which will be set by any of the three constructors
    ///
    ///[Button] - for [PrimaryButton], set [ButtonType] to [ButtonType.primary]
    ///[Button.secondary] - for [SecondaryButton], set [ButtonType] to [ButtonType.secondary]
    ///[Button.outlined] - for [OutlinedButton], set [ButtonType] to [ButtonType.outlined]

    switch (buttonType) {
      case ButtonType.primary:
        const Color _buttonColor = kPrimaryColor;
        const Color _lableColor = kTextColorDark;
        Widget button = ElevatedButton(
          onPressed: onTap,
          child: Text(
            label,
            style: Get.textTheme.button!.copyWith(
              color: labelColor ?? _lableColor,
              fontSize: fontSize,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: buttonColor ?? _buttonColor,
            padding: padding,
            shape: border,
          ),
        );
        if (width != null) {
          return SizedBox(
            width: width,
            child: button,
          );
        }
        return button;

      case ButtonType.secondary:
        return Obx(
          () {
            final Color _buttonColor = themeController.isDarkMode
                ? kSecondaryColorDark
                : kSecondaryColorLight;
            final Color _labelColor =
                themeController.isDarkMode ? kTextColorDark : kPrimaryColor;
            Widget button = ElevatedButton(
              onPressed: onTap,
              child: Text(
                label,
                style: Get.textTheme.button!.copyWith(
                  color: labelColor ?? _labelColor,
                  fontSize: fontSize,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: buttonColor ?? _buttonColor,
                padding: padding,
                shape: border,
              ),
            );
            if (width != null) {
              return SizedBox(
                width: width,
                child: button,
              );
            }
            return button;
          },
        );

      case ButtonType.outlined:
        return Obx(
          () {
            final Color _buttonColor = themeController.isDarkMode
                ? kBackgroundColorDark
                : kBackgroundColorLight;
            final Color _labelColor =
                themeController.isDarkMode ? kTextColorDark : kPrimaryColor;

            Widget button = OutlinedButton(
              onPressed: onTap,
              child: Text(label),
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith((states) => padding),
                shape: MaterialStateProperty.resolveWith((states) => border),
                textStyle: MaterialStateProperty.resolveWith(
                  (state) => Get.textTheme.button!.copyWith(fontSize: fontSize),
                ),
                side: MaterialStateProperty.resolveWith(
                  (states) => BorderSide(
                    width: outlineWidth,
                    color: buttonColor ?? _labelColor,
                  ),
                ),
                overlayColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> buttonStates) {
                  if (buttonStates.contains(MaterialState.pressed)) {
                    return buttonColor ?? _labelColor;
                  }
                  return buttonColor ?? _buttonColor;
                }),
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> buttonStates) {
                  if (buttonStates.contains(MaterialState.pressed)) {
                    return _buttonColor;
                  }
                  return labelColor ?? _labelColor;
                }),
              ),
            );

            if (width != null) {
              return SizedBox(
                width: width,
                child: button,
              );
            }
            return button;
          },
        );

      default:
        const Color _buttonColor = kPrimaryColor;
        const Color _lableColor = kTextColorDark;
        Widget button = ElevatedButton(
          onPressed: onTap,
          child: Text(
            label,
            style: Get.textTheme.button!.copyWith(
              color: labelColor ?? _lableColor,
              fontSize: fontSize,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: buttonColor ?? _buttonColor,
            padding: padding,
            shape: border,
          ),
        );
        if (width != null) {
          return SizedBox(
            width: width,
            child: button,
          );
        }
        return button;
    }
  }
}
