import 'package:banking_app/data/local/storage_repository.dart';
import 'package:banking_app/screens/auth/register/register_screen.dart';
import 'package:flutter/material.dart';

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
                // BoardingPageOne(),
                // BoardingPageTwo(),
                // BoardingPageThree(),
              ],
            ),
          ),
          TextButton(
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
            child: Text("Next"),
          )
        ],
      ),
    );
  }
}
