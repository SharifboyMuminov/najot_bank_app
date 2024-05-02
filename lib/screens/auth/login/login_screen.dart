import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/blocs/auth/auth_event.dart';
import 'package:untitled1/blocs/auth/auth_state.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/screens/auth/widgets/save_button.dart';
import 'package:untitled1/screens/auth/widgets/universal_text_input.dart';
import 'package:untitled1/screens/routes.dart';
import 'package:untitled1/utils/app_contains.dart';
import 'package:untitled1/utils/app_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppImages.imgForRegister),
                UniversalTextInput(
                  controller: emailController,
                  hintText: "Enter email...",
                  type: TextInputType.emailAddress,
                  regExp: AppConstants.emailRegExp,
                  errorTitle: "invalid input :(",
                  onChange: (String value) {
                    setState(() {});
                  },
                ),
                UniversalTextInput(
                  controller: passwordController,
                  hintText: "Enter password...",
                  type: TextInputType.emailAddress,
                  regExp: AppConstants.passwordRegExp,
                  errorTitle: "invalid input :(",
                  onChange: (String value) {
                    setState(() {});
                  },
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
                        Navigator.pop(context);
                      },
                      child: Text(
                        " Register now",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SaveButton(
                  onTab: () {
                    context.read<AuthBloc>().add(
                          AuthLoginEvent(
                              password: passwordController.text,
                              email: emailController.text),
                        );
                  },
                  loading: state.formStatus == FormStatus.loading,
                  active: checkInput,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool get checkInput {
    return AppConstants.emailRegExp.hasMatch(emailController.text) &&
        AppConstants.passwordRegExp.hasMatch(passwordController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
