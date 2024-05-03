import 'package:flutter/material.dart';
import 'package:untitled1/data/models/user/user_model.dart';
import 'package:untitled1/screens/payment/payment_screen.dart';
import 'package:untitled1/screens/splash/splash_screen.dart';
import 'package:untitled1/screens/tab_box/profile/update_user.dart';
import 'package:untitled1/screens/tab_box/tab_screen.dart';
import 'package:untitled1/screens/transfer/transfer_screen.dart';

import 'auth/register/register_screen.dart';
import 'no_internet/no_internet_screen.dart';
import 'on_boarding/on_boarding_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.tabRoute:
        return navigate(const TabScreen());

      case RouteNames.noInternetRoute:
        return navigate(NoInternetScreen(
            onInternetComeBack: settings.arguments as VoidCallback));

      case RouteNames.transferRoute:
        return navigate(const TransferScreen());
      case RouteNames.paymentRoute:
        return navigate(const PaymentScreen());
      case RouteNames.authRoute:
        return navigate(const RegisterScreen());
      case RouteNames.onBoardingRoute:
        return navigate(const OnBoardingScreen());
      case RouteNames.updateUser:
        return navigate(UpdateUserScreen(
          userModel: settings.arguments as UserModel,
        ));

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String tabRoute = "/tab_route";
  static const String authRoute = "/auth_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String transferRoute = "/transfer_route";
  static const String onBoardingRoute = "/on_boarding_route";
  static const String updateUser = "/update_user";
}
