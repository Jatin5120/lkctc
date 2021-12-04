import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constants.dart';
import '../widgets/widgets.dart';

class StudentLoginView extends StatelessWidget {
  const StudentLoginView({Key? key}) : super(key: key);
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                Label('Student Login', style: Get.textTheme.headline6),
                const SizedBox(height: 32),
                InputField(
                  label: 'Email',
                  hint: 'Enter email',
                  controller: _emailController,
                ),
                InputField(
                  label: 'Password',
                  hint: 'Enter password',
                  controller: _passwordController,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Label(
                      'Dont have an account? ',
                      style: Get.textTheme.bodyText2,
                    ),
                    Label(
                      ' Sign Up',
                      style: Get.textTheme.bodyText2!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Button(
                  label: 'Login',
                  buttonSize: ButtonSize.large,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
