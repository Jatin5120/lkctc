import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../faculty.dart';

class FacultyLoginView extends GetView<FacultyController> {
  const FacultyLoginView({Key? key}) : super(key: key);

  static final TextEditingController _emailController = TextEditingController();
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
                Label.primary('Faculty Login', style: Get.textTheme.headline6),
                const SizedBox(height: 32),
                InputField(
                  label: 'Email',
                  hint: 'Enter email',
                  controller: _emailController,
                ),
                Obx(
                  () => InputField(
                    label: 'Password',
                    hint: 'Enter password',
                    controller: _passwordController,
                    obscureText: controller.hidePassword,
                    textInputAction: TextInputAction.done,
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
                const Spacer(),
                RegisterText(
                  onTap: () => Get.offNamed(FacultyRoutes.register),
                ),
                const SizedBox(height: 24),
                Button(
                  label: 'Login',
                  buttonSize: ButtonSize.large,
                  onTap: () {
                    FacultyService.login(
                      _emailController.text,
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
