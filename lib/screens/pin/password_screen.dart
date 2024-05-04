import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/data/local/storage_repository.dart';
import 'package:untitled1/screens/pin/widget/password_buttons.dart';
import 'package:untitled1/screens/routes.dart';
import 'package:untitled1/service/local_auth.dart';
import 'package:untitled1/utils/size_utils.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen>
    with SingleTickerProviderStateMixin {
  late Animation<Alignment> animationAlign;
  late AnimationController animationController;
  List<String> password = [];

  String pinCode = '';
  bool error = false;
  bool reversAnimation = false;

  _init() {
    pinCode = StorageRepository.getString(key: "pin_code");
    _checkBiometricsTest();

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
                "Enter your passcode",
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
                showTouchId: StorageRepository.getBool(key: "active_touch"),
                onChange: (String value) {
                  if (password.length < 4) {
                    password.add(value);
                    if (password.length == 4) {
                      if (password.join() == pinCode) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RouteNames.tabRoute, (route) => false);
                      } else {
                        _invalidPassword();
                      }
                    }
                  }

                  setState(() {});
                },
                onTabClear: () {
                  if (password.isNotEmpty) {
                    password.removeLast();
                    setState(() {});
                  }
                },
                onTabTouchId: _checkBiometricsTest,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkBiometricsTest() async {
    bool auth = await BiometricAuthService.authenticateTest();
    if (auth) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.tabRoute, (route) => false);
    }
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
}
