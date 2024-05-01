import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/auth/widgets/universal_text_input.dart';
import 'package:untitled1/utils/app_contains.dart';
import 'package:untitled1/utils/app_images.dart';
import 'package:untitled1/utils/size_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppImages.imgForRegister),
                  UniversalTextInput(
                    controller: firstNameController,
                    hintText: "Enter first name...",
                    type: TextInputType.text,
                    regExp: AppConstants.textRegExp,
                    errorTitle: "invalid input :(",
                  ),
                  UniversalTextInput(
                    controller: lastNameController,
                    hintText: "Enter last name...",
                    type: TextInputType.text,
                    regExp: AppConstants.textRegExp,
                    errorTitle: "invalid input :(",
                  ),
                  UniversalTextInput(
                    controller: emailController,
                    hintText: "Enter email...",
                    type: TextInputType.emailAddress,
                    regExp: AppConstants.emailRegExp,
                    errorTitle: "invalid input :(",
                  ),
                  UniversalTextInput(
                    controller: passwordController,
                    hintText: "Enter password...",
                    type: TextInputType.emailAddress,
                    regExp: AppConstants.passwordRegExp,
                    errorTitle: "invalid input :(",
                  ),
                ],
              ),
            ),
          ),
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {},
              child: Text("asdf")),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
