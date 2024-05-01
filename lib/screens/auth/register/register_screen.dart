import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/screens/auth/login/login_screen.dart';
import 'package:untitled1/screens/auth/widgets/universal_text_input.dart';
import 'package:untitled1/utils/app_colors.dart';
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
      body: SingleChildScrollView(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    " Login now",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                onPressed: () {},
                child: Text(
                  "asdf",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
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
