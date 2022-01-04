import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';
import 'package:lkctc_student_app/faculty/service.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/routes/routes.dart';
import '../constants/constants.dart';
import '../widgets/widgets.dart';

class FacultyRegisterView extends GetView<FacultyController> {
  const FacultyRegisterView({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _phoneController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  static String _designation = '';
  static String _department = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        reverse: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width.tenPercent,
            vertical: size.height.fivePercent,
          ).copyWith(top: size.height.tenPercent),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width.thirtyPercent,
                  width: size.width.thirtyPercent,
                  child: const LKCTCLogo(),
                ),
                const SizedBox(height: 48),
                Label.primary(
                  'Register as Faculty',
                  style: Get.textTheme.headline6,
                ),
                const SizedBox(height: 32),
                InputField(
                  label: 'Name',
                  hint: 'Enter your name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name can't be empty";
                    }
                    return null;
                  },
                ),
                InputField(
                  label: 'Email',
                  hint: 'Enter email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name can't be empty";
                    }
                    return null;
                  },
                ),
                InputField(
                  label: 'Phone',
                  hint: 'Enter mobile number',
                  controller: _phoneController,
                  textInputType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name can't be empty";
                    }
                    if (!value.isNumericOnly) {
                      return "Only numbers are allowed (0-9)";
                    }
                    if (value.length < 10) {
                      return "Mobile number should be of 10 digits";
                    }
                    return null;
                  },
                ),
                DropDown<String>(
                  label: 'Designation',
                  items: kDesignations,
                  onChanged: (value) {
                    _designation = value!;
                  },
                ),
                DropDown<String>(
                  label: 'Department',
                  items: kDepartments,
                  onChanged: (value) {
                    _department = value!;
                  },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password can't be empty";
                      }
                      if (value.length < 8) {
                        return "Minimum length should be 8";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 56),
                LoginText(
                  onTap: () => Get.offNamed(FacultyRoutes.login),
                ),
                const SizedBox(height: 24),
                Button(
                  label: 'Register',
                  buttonSize: ButtonSize.large,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final FacultyModal facultyModal = FacultyModal(
                        userID: '',
                        facultyID: '',
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        password: _passwordController.text,
                        department: _department,
                        designation: _designation,
                      );
                      FacultyService.addFaculty(facultyModal);
                    }
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
