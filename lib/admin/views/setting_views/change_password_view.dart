import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/admin/admin.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/services/dialog_service.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class AdminChangePasswordView extends StatelessWidget {
  const AdminChangePasswordView({Key? key}) : super(key: key);

  static final AdminController _adminController = Get.find();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final TextEditingController _oldController = TextEditingController();
  static final TextEditingController _newController = TextEditingController();

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      final bool changed =
          await AdminService.changePassword(_newController.text);

      if (changed) {
        DialogService.showSuccessDialog(
            message: 'Your password has been changed');
        _oldController.text = "";
        _newController.text = "";
      } else {
        DialogService.showErrorDialog(
          title: 'Password not changed',
          message: 'Unknown error occured, Kindly try again after some time',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Change Password'),
      body: StreamBuilder<DocumentSnapshot>(
          stream: AdminService.adminStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final String password = data['password'];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24)
                  .copyWith(top: 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Obx(
                      () => InputField(
                        label: 'Current Password',
                        hint: 'Enter old password',
                        controller: _oldController,
                        obscureText: _adminController.hidePassword,
                        textCapitalization: TextCapitalization.none,
                        suffixIcon: IconButton(
                          icon: _adminController.hidePassword
                              ? const Icon(Icons.visibility_rounded)
                              : const Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            _adminController.hidePassword =
                                !_adminController.hidePassword;
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Required";
                          }
                          if (value != password) {
                            return "Incorrect Password";
                          }
                          return null;
                        },
                      ),
                    ),
                    Obx(
                      () => InputField(
                        label: 'New Password',
                        hint: 'Enter new password',
                        controller: _newController,
                        obscureText: _adminController.hideNewPassword,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.none,
                        suffixIcon: IconButton(
                          icon: _adminController.hideNewPassword
                              ? const Icon(Icons.visibility_rounded)
                              : const Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            _adminController.hideNewPassword =
                                !_adminController.hideNewPassword;
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Required";
                          }
                          if (value == _oldController.text) {
                            return "New password cannot be same as Old password";
                          }
                          return null;
                        },
                      ),
                    ),
                    const Spacer(),
                    Button(
                      label: 'Change Password',
                      buttonSize: ButtonSize.large,
                      onTap: _changePassword,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
