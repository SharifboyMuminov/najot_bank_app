import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/screens/pin/widget/password_buttons.dart';
import 'package:untitled1/screens/routes.dart';
import 'package:untitled1/utils/size_utils.dart';

import '../../../data/local/storage_repository.dart';

class PasswordSetScreen extends StatefulWidget {
  const PasswordSetScreen({super.key});

  @override
  State<PasswordSetScreen> createState() => _PasswordSetScreenState();
}

class _PasswordSetScreenState extends State<PasswordSetScreen> {
  List<String> password = [];

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
                "Enter your new passcode",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              50.getH(),
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            4,
                            (index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 30.we),
                                width: 15.we,
                                height: 15.we,
                                decoration: BoxDecoration(
                                  color: password.length > index
                                      ? Colors.green
                                      : Colors.white38,
                                  shape: BoxShape.circle,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PasswordButtons(
                onChange: (String value) {
                  if (password.length < 4) {
                    password.add(value);
                    if (password.length == 4) {
                      StorageRepository.setString(
                          key: "pin_code", value: password.join());
                      password = [];
                      Navigator.pushNamed(context, RouteNames.pinTestScreen);
                    }
                  }

                  setState(() {});
                },
                onTabClear: () {
                  password.removeLast();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
