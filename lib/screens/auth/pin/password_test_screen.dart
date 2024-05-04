import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/data/local/storage_repository.dart';
import 'package:untitled1/screens/auth/pin/widget/password_buttons.dart';
import 'package:untitled1/screens/routes.dart';
import 'package:untitled1/service/local_auth.dart';
import 'package:untitled1/utils/size_utils.dart';

class PasswordTestScreen extends StatefulWidget {
  const PasswordTestScreen({super.key});

  @override
  State<PasswordTestScreen> createState() => _PasswordTestScreenState();
}

class _PasswordTestScreenState extends State<PasswordTestScreen>
    with SingleTickerProviderStateMixin {
  late Animation<Alignment> animationAlign;
  late AnimationController animationController;
  List<String> password = [];

  String pinCode = '';
  bool error = false;
  bool reversAnimation = false;

  _init() {
    pinCode = StorageRepository.getString(key: "pin_code");
    setState(() {});
  }

  @override
  void initState() {
    _init();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    animationAlign = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween: Tween(begin: Alignment.center, end: Alignment.centerLeft),
          weight: 40),
      TweenSequenceItem<Alignment>(
          tween: Tween(begin: Alignment.centerLeft, end: Alignment.center),
          weight: 40),
      TweenSequenceItem<Alignment>(
          tween: Tween(begin: Alignment.centerRight, end: Alignment.center),
          weight: 40),
    ]).animate(
        CurvedAnimation(parent: animationController, curve: Curves.decelerate));

    animationController.addListener(() {
      // debugPrint("New Anumation :)");
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF252525),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Color(0xFF252525),
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.we),
          child: Column(
            children: [
              70.getH(),
              Text(
                "Security screen",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.sp,
                ),
              ),
              50.getH(),
              Text(
                "Enter your passcode revers",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              50.getH(),
              Align(
                alignment: animationAlign.value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      4,
                      (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.we),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: password.length > index
                                ? error
                                    ? Colors.red
                                    : Colors.green
                                : Colors.white38,
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              PasswordButtons(
                onChange: _change,
                onTabClear: () {
                  if (password.isNotEmpty) {
                    password.removeLast();
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _invalidPassword() async {
    error = true;
    if (reversAnimation) {
      animationController.reverse();
      reversAnimation = false;
    } else {
      animationController.forward();
      reversAnimation = true;
    }

    await Future.delayed(const Duration(seconds: 1));
    password = [];
    error = false;
    setState(() {});
  }

  Future<void> _change(String value) async {
    if (password.length < 4) {
      password.add(value);
      if (password.length == 4) {
        if (password.join() == pinCode) {
          if (await BiometricAuthService.canAuthenticate()) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog.adaptive(
                    title: Row(
                      children: [
                        Icon(
                          Icons.face,
                          color: Colors.black,
                          size: 100.sp,
                        ),
                        Icon(
                          Icons.touch_app,
                          color: Colors.black,
                          size: 100.sp,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, RouteNames.tabRoute, (route) => false);
                        },
                        child: Text(
                          "skip",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                        onPressed: () {
                          StorageRepository.setBool(
                              key: "active_touch", value: true);

                          BiometricAuthService.authenticate();

                          Navigator.pushNamedAndRemoveUntil(
                              context, RouteNames.tabRoute, (route) => false);
                        },
                        child: Text(
                          "active",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.tabRoute, (route) => false);
          }
        } else {
          _invalidPassword();
        }
      }
    }

    setState(() {});
  }
}
