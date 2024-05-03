import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/blocs/auth/auth_event.dart';
import 'package:untitled1/blocs/auth/auth_state.dart';
import 'package:untitled1/blocs/user_profile/user_profile_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_event.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/data/models/user/user_model.dart';
import 'package:untitled1/screens/auth/login/login_screen.dart';
import 'package:untitled1/screens/auth/widgets/save_button.dart';
import 'package:untitled1/screens/auth/widgets/universal_text_input.dart';
import 'package:untitled1/screens/routes.dart';
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
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  UserModel userModel = UserModel.initial();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Column(
            children: [
              Image.asset(AppImages.imgForRegister),
              UniversalTextInput(
                controller: fullNameController,
                hintText: "Enter full name...",
                type: TextInputType.text,
                regExp: AppConstants.textRegExp,
                errorTitle: "invalid input :(",
                onChange: (String value) {
                  setState(() {});
                },
              ),
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
              SaveButton(
                onTab: () {
                  List<String> full = fullNameController.text.split(" ");
                  userModel = userModel.copyWith(
                    lastName: full.first,
                    userName: full.last,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  context
                      .read<AuthBloc>()
                      .add(AuthRegisterEvent(userModel: userModel));
                },
                loading: state.formStatus == FormStatus.loading,
                active: checkInput,
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, AuthState state) {
        if (state.formStatus == FormStatus.error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state.formStatus == FormStatus.authenticated) {
          if (state.statusMessage == "new_user") {
            // debugPrint("O'hshadi :)");
            context
                .read<UserProfileBloc>()
                .add(AddUserProfileEvent(userModel: userModel));
          }
          Navigator.pushNamedAndRemoveUntil(
              context, RouteNames.tabRoute, (route) => false);
        }
      },
    ));
  }

  bool get checkInput {
    return AppConstants.emailRegExp.hasMatch(emailController.text) &&
        AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
        fullNameController.text.length > 8;
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
