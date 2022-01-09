import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/admin/admin.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class AdminLoginView extends GetView<AdminController> {
  const AdminLoginView({Key? key}) : super(key: key);

  static final TextEditingController _idController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width.tenPercent,
              vertical: size.height.fivePercent,
            ).copyWith(top: size.height.tenPercent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width.thirtyPercent,
                  width: size.width.thirtyPercent,
                  child: const LKCTCLogo(),
                ),
                const SizedBox(height: 48),
                Label.primary('Admin Login', style: Get.textTheme.headline6),
                const SizedBox(height: 32),
                InputField(
                  label: 'Admin ID',
                  hint: 'Enter admin id',
                  controller: _idController,
                  textCapitalization: TextCapitalization.none,
                ),
                Obx(
                  () => InputField(
                    label: 'Admin Password',
                    hint: 'Enter admin password',
                    controller: _passwordController,
                    obscureText: controller.hidePassword,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.none,
                    suffixIcon: IconButton(
                      icon: controller.hidePassword
                          ? const Icon(Icons.visibility_rounded)
                          : const Icon(Icons.visibility_off_outlined),
                      onPressed: () {
                        controller.hidePassword = !controller.hidePassword;
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      controller.error,
                      style: Get.textTheme.subtitle1!.copyWith(
                        color: kErrorColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Button(
                  label: 'Login',
                  buttonSize: ButtonSize.large,
                  onTap: () {
                    AdminService.login(
                      _idController.text,
                      _passwordController.text,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
