import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class DialogService {
  const DialogService._();

  static final ThemeController _themeController = Get.find();

  /// This method shows a [Loading dialog] as an [Overlay] on the screen
  ///
  /// This uses `Get` library to show a `Dialog` with a `CircularProgressIndicator`
  ///
  /// This accepts only one parameter
  /// ```dart
  /// String title
  /// ```
  ///
  /// * To Close this dialog, use `closeDialog` method of the same `DialogService` class
  ///
  /// ```dart
  /// DialogService.closeDialog()
  /// ```
  static void showLoadingDialog({String? message}) {
    Get.dialog(
      Dialog(
        elevation: kElevation,
        shape: kLargeBorder,
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: message == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(width: 16),
                Text(message, style: Get.textTheme.subtitle1),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// This method shows a [Confirmation dialog] as an [Overlay] on the screen
  ///
  /// This uses `Get` library to show a `Dialog` with [Action] buttons, you can use `Button` class for actions
  ///
  /// This accepts two required parameters
  /// ```dart
  /// String title;
  /// List<Widget> actions;
  /// ```
  /// And one optional parameter
  /// ```dart
  /// String description;
  /// ```
  ///
  /// * To Close this dialog, use `closeDialog` method of the same `DialogService` class
  ///
  /// ```dart
  /// DialogService.closeDialog()
  /// ```
  static Future<void> showConfirmationDialog({
    required String title,
    String? description,
    required List<Widget> actions,
  }) async {
    await Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(12).copyWith(top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(kIllustrationPath + 'confirmation.png'),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Get.textTheme.headline6,
              ),
              if (description != null) ...[
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 32),
              for (Widget action in actions) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.maxFinite,
                  child: action,
                ),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// This method shows a [Success dialog] as an [Overlay] on the screen
  ///
  /// This uses `Get` library to show a `Dialog` with a the Error message
  ///
  /// And two optional named parameters
  /// ```dart
  /// String title
  /// String message
  /// ```
  /// which defaults to 'Error'
  ///
  /// * To Close this dialog, use `closeDialog` method of the same `DialogService` class
  ///
  /// ```dart
  /// DialogService.closeDialog()
  /// ```
  static void showSuccessDialog({
    String title = 'Success',
    String message = 'Done',
  }) async {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(kIllustrationPath + 'success.png'),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: Get.textTheme.headline6!.copyWith(color: kSuccessColor),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
    await Future.delayed(kDelayDuration);

    closeDialog();
  }

  /// This method shows a [Error dialog] as an [Overlay] on the screen
  ///
  /// This uses `Get` library to show a `Dialog` with a the Error message
  ///
  /// And two optional named parameters
  /// ```dart
  /// String title
  /// String message
  /// ```
  /// which defaults to 'Error'
  ///
  /// * To Close this dialog, use `closeDialog` method of the same `DialogService` class
  ///
  /// ```dart
  /// DialogService.closeDialog()
  /// ```
  static void showErrorDialog({
    String title = 'Error',
    String message = 'Something went wrong. Please try again after some time',
  }) {
    Get.dialog(
      Dialog(
        child: SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(12).copyWith(top: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
                  child: Image.asset(kIllustrationPath + 'problem.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: Get.textTheme.headline6!.copyWith(color: kErrorColor),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  // style: Get.textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                const SizedBox(
                  width: double.maxFinite,
                  child: Button(
                    label: "Okay, I’ll try later",
                    buttonSize: ButtonSize.medium,
                    buttonColor: kErrorColor,
                    onTap: closeDialog,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> showColorDialog() async {
    int colorIndex = _themeController.colorIndex;
    await Get.dialog(
      SizedBox(
        child: AlertDialog(
          title: Text('Select Color', style: Get.textTheme.headline6),
          insetPadding: EdgeInsets.symmetric(
            horizontal: Get.size.width.tenPercent,
            vertical: Get.size.height.twentyPercent,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          content: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: kSubjectColors.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  _themeController.colorIndex = index;
                },
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kSubjectColors[index],
                    ),
                    child: _themeController.colorIndex == index
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Button.secondary(
              label: 'Cancel',
              buttonSize: ButtonSize.small,
              onTap: () {
                _themeController.colorIndex = colorIndex;
                closeDialog();
              },
            ),
            const Button(
              label: 'Select',
              buttonSize: ButtonSize.small,
              onTap: closeDialog,
            ),
          ],
        ),
      ),
    );
  }

  /// This method shows a [Snackbar] at the top of the screen for a `Duration` of 3 seconds
  ///
  /// This uses `Get` library to show a `Snackbar` with a the title and message.
  ///
  /// This accepts two positional parameter
  /// ```dart
  /// String title
  /// String message
  /// ```
  /// And one optional named parameter
  /// ```dart
  /// DialogType dialogType
  /// ```
  /// which defaults to `DialogType.normal`
  ///
  /// Other possible values -
  /// * `DialogType.success`
  /// * `DialogType.warning`
  /// * `DialogType.error`
  ///
  /// The snakbar will automatically close after 3 seconds
  static void showSnackBar(
    String title,
    String message, {
    DialogType dialogType = DialogType.normal,
  }) {
    late Color backgroundColor;
    late IconData icon;

    switch (dialogType) {
      case DialogType.success:
        backgroundColor = kSuccessColor;
        icon = Icons.done_rounded;
        break;
      case DialogType.warning:
        backgroundColor = kWarningColor;
        icon = Icons.warning_amber_rounded;
        break;
      case DialogType.error:
        backgroundColor = kErrorColor;
        icon = Icons.error_outline_rounded;
        break;
      case DialogType.normal:
      default:
        backgroundColor = kNormalColor;
        icon = Icons.info_outline_rounded;
        break;
    }

    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: kWhiteColor,
      icon: Icon(icon, color: kWhiteColor),
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: kHintTextColor,
      textColor: kBlackColor,
    );
  }

  static void closeDialog<T>([T? result]) {
    if (Get.isDialogOpen!) {
      Get.back(result: result);
    }
  }
}
