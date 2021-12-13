import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '/constants/constants.dart';

ThemeData kLightTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundColorLight,
  primaryColor: kPrimaryColor,
  backgroundColor: kBackgroundColorLight,
  brightness: Brightness.light,
  cardTheme: const CardTheme(
    color: kCardColorLight,
    shadowColor: kShadowColorLight,
    elevation: 10,
    shape: kLargeBorder,
  ),
  textTheme: kTextTheme,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kAccentColorLight,
    elevation: kElevation,
    foregroundColor: kTextColorDark,
  ),
  popupMenuTheme: const PopupMenuThemeData(
    elevation: kElevation,
    color: kCardColorLight,
    shape: kSmallBorder,
  ),
  shadowColor: kShadowColorLight,
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(
      borderRadius: kMediumRadius,
      borderSide: BorderSide(
        color: kHintTextColor,
        width: 1,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: kMediumRadius,
      borderSide: BorderSide(
        color: kHintTextColor,
        width: 1,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: kMediumRadius,
      borderSide: BorderSide(
        color: kPrimaryColor,
        width: 2,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: kMediumRadius,
      borderSide: BorderSide(
        color: kErrorColor,
        width: 2,
      ),
    ),
    fillColor: kCardColorLight,
    filled: true,
    hintStyle: Get.textTheme.bodyText1!.copyWith(color: kHintTextColor),
    labelStyle: Get.textTheme.subtitle1!.copyWith(color: kTextColorLight),
    errorStyle: Get.textTheme.overline!.copyWith(color: kErrorColor),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: kCardColorLight,
    elevation: kElevation,
    shape: kMediumBorder,
    titleTextStyle: Get.textTheme.headline6!.copyWith(color: kTextColorLight),
    contentTextStyle:
        Get.textTheme.subtitle2!.copyWith(color: kCaptionColorLight),
  ),
  iconTheme: const IconThemeData(color: kIconColorLight),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: kPrimaryColor,
    refreshBackgroundColor: kSecondaryColorLight,
  ),
);

ThemeData kDarkTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundColorDark,
  primaryColor: kPrimaryColor,
  backgroundColor: kBackgroundColorDark,
  brightness: Brightness.dark,
  cardTheme: const CardTheme(
    color: kCardColorDark,
    shadowColor: kShadowColorDark,
    elevation: 10,
    shape: kLargeBorder,
  ),
  textTheme: kTextTheme,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kAccentColorDark,
    elevation: kElevation,
    foregroundColor: kTextColorDark,
  ),
  popupMenuTheme: const PopupMenuThemeData(
    elevation: kElevation,
    color: kCardColorDark,
    shape: kSmallBorder,
  ),
  shadowColor: kShadowColorDark,
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(
      borderRadius: kMediumRadius,
      borderSide: BorderSide(
        color: kHintTextColor,
        width: 1,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: kMediumRadius,
      borderSide: BorderSide(
        color: kHintTextColor,
        width: 1,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: kMediumRadius,
      borderSide: BorderSide(
        color: kTextColorDark,
        width: 2,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: kMediumRadius,
      borderSide: BorderSide(
        color: kErrorColor,
        width: 2,
      ),
    ),
    fillColor: kCardColorDark,
    filled: true,
    hintStyle: Get.textTheme.bodyText1!.copyWith(color: kHintTextColor),
    labelStyle: Get.textTheme.subtitle1!.copyWith(color: kTextColorDark),
    errorStyle: Get.textTheme.overline!.copyWith(color: kErrorColor),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: kCardColorDark,
    elevation: kElevation,
    shape: kMediumBorder,
    titleTextStyle: Get.textTheme.headline6!.copyWith(color: kTextColorDark),
    contentTextStyle:
        Get.textTheme.subtitle2!.copyWith(color: kCaptionColorDark),
  ),
  iconTheme: const IconThemeData(color: kIconColorDark),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: kWhiteColor,
    refreshBackgroundColor: kSecondaryColorDark,
  ),
);

TextTheme kTextTheme = TextTheme(
  headline1: GoogleFonts.firaSans(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.firaSans(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.firaSans(
    fontSize: 48,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.firaSans(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.firaSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.firaSans(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.firaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.firaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);
