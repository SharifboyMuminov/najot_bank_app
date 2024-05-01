import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/data/local/storage_repository.dart';
import 'package:untitled1/screens/auth/register/register_screen.dart';
import 'package:untitled1/screens/on_boarding/on_boarding_screen.dart';
import 'package:untitled1/screens/tab_box/tab_screen.dart';
import 'package:untitled1/utils/size_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (isNewUser) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreen(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TabScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    // debugPrint("Qonday");
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.access_time_filled_outlined,
          color: Colors.green,
          size: 200,
        ),
      ),
    );
  }
}
