import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/blocs/auth/auth_event.dart';
import 'package:untitled1/blocs/card/card_event.dart';
import 'package:untitled1/blocs/connectivity/connectivity_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_bloc.dart';
import 'package:untitled1/data/repository/auth_repository.dart';
import 'package:untitled1/data/repository/card_repository.dart';
import 'package:untitled1/data/repository/user_repository.dart';
import 'package:untitled1/screens/routes.dart';
import 'package:untitled1/service/local_natification_service.dart';

import '../blocs/card/card_bloc.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => CardRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ConnectivityBloc()),
          BlocProvider(
              create: (context) =>
                  UserProfileBloc(context.read<UserRepository>())),
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(AuthCheckEvent()),
          ),
          BlocProvider(
              create: (context) => CardBloc(context.read<CardRepository>())..add(CallCardsEvent()))
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNames.splashScreen,
              navigatorKey: navigatorKey,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
