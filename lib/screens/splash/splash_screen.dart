import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/blocs/auth/auth_state.dart';
import 'package:untitled1/data/local/storage_repository.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/screens/routes.dart';
import 'package:untitled1/utils/size_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init(FormStatus formState) {
    if (formState == FormStatus.authenticated) {
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    } else {
      bool onboard = StorageRepository.getBool(key: "onboard");
      if (onboard) {
        Navigator.pushReplacementNamed(context, RouteNames.authRoute);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          _init(state.formStatus);
          return Center(
            child: Icon(
              Icons.access_time_filled_outlined,
              color: Colors.green,
              size: 200,
            ),
          );
        },
      ),
    );
  }
}
