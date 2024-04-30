import 'package:banking_app/blocs/auth/auth_bloc.dart';
import 'package:banking_app/blocs/auth/auth_event.dart';
import 'package:banking_app/blocs/auth/auth_state.dart';
import 'package:banking_app/screens/auth/login/login_screen.dart';
import 'package:banking_app/utils/app_colors.dart';
import 'package:banking_app/utils/app_constants.dart';
import 'package:banking_app/utils/app_images.dart';
import 'package:banking_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

bool isChecked = false;

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthErrorState) {
              return Center(child: Text(state.errorText));
            }
            if (state is AuthInitialState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            AppImages.registerImage,
                            height: 250.h,
                          ),
                        ),
                        16.getH(),
                        Text("Sign Up",
                            style: Theme.of(context).textTheme.bodyLarge),
                        16.getH(),
                        UniversalTextInput(
                          controller: firstNameController,
                          hintText: "First Name",
                          type: TextInputType.text,
                          regExp: AppConstants.textRegExp,
                          errorTitle: 'First Name',
                          iconPath: AppImages.profile,
                        ),
                        16.getH(),
                        UniversalTextInput(
                          controller: lastNameController,
                          hintText: "Last Name",
                          type: TextInputType.text,
                          regExp: AppConstants.textRegExp,
                          errorTitle: 'Last Name',
                          iconPath: AppImages.profile,
                        ),
                        16.getH(),
                        UniversalTextInput(
                          controller: emailController,
                          hintText: "Email",
                          type: TextInputType.emailAddress,
                          regExp: AppConstants.emailRegExp,
                          errorTitle: 'E-mail',
                          iconPath: AppImages.email,
                        ),
                        16.getH(),
                        PasswordTextInput(
                          controller: passwordController,
                        ),
                        16.getH(),
                        PasswordTextInput(
                          controller: confirmPasswordController,
                        ),
                        13.getH(),
                        TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 18.h, horizontal: 80.w),
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24))),
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    AuthRegisterEvent(
                                      name:
                                          "${firstNameController.text} $lastNameController",
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                            },
                            child: Text("SIGNUP",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.white))),
                        13.getH(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const LoginScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Text("Login"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          listener: (BuildContext context, AuthState state) {
            if (state is AuthSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
