import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/blocs/auth/auth_state.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/app_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isChecked = false;

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparent,
            statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthErrorState) {
                return Center(
                  child: Text(state.errorText),
                );
              }
              if (state is AuthInitialState) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 44.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Image.asset(
                            AppImages.loginImage,
                            height: 300.h(),
                            fit: BoxFit.cover,
                          ),
                          16.getH(),
                          Text("LOGIN",
                              style: Theme.of(context).textTheme.bodyLarge),
                          UniversalTextInput(
                            controller: emailController,
                            hintText: "Email",
                            type: TextInputType.emailAddress,
                            regExp: AppConstants.emailRegExp,
                            errorTitle: 'E-mail',
                            iconPath: AppImages.email,
                          ),
                          20.getH(),
                          PasswordTextInput(
                            controller: passwordController,
                          ),
                          13.getH(),
                          Row(
                            children: [
                              Switch(
                                value: isChecked,
                                onChanged: (bool value) {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                              ),
                              3.getW(),
                              Text(
                                "Remember Me",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ))
                            ],
                          ),
                          13.getH(),
                          TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 18.h, horizontal: 80.w),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24))),
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      AuthLoginEvent(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                              },
                              child: Text("LOGIN",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.white))),
                          13.getH(),
                          Text("OR",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 14)),
                          10.getH(),
                          Text("Login with",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 12)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w()),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      AppImages.google,
                                      height: 24.h,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      AppImages.apple,
                                      height: 24.h,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      AppImages.facebook,
                                      height: 24.h,
                                    ))
                              ],
                            ),
                          ),
                          13.getH(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don’t have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text("Register now"))
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