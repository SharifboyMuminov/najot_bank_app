import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/data/local/storage_repository.dart';
import 'package:untitled1/screens/auth/register/register_screen.dart';
import 'package:untitled1/utils/app_images.dart';
import 'package:untitled1/utils/size_utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (index) {},
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Image.asset(AppImages.imgOnePng),
                Image.asset(AppImages.imgTwoPng),
                Image.asset(AppImages.imgThreePng),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15.h)),
              onPressed: () {
                if (activeIndex == 2) {
                  StorageRepository.setBool(
                    key: "is_new_user",
                    value: true,
                  ).then(
                    (value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                  );
                } else {
                  activeIndex += 1;
                  controller.animateToPage(
                    activeIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                }
              },
              child: Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
