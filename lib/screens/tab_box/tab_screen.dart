import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/card/card_bloc.dart';
import 'package:untitled1/blocs/card/card_event.dart';
import 'package:untitled1/blocs/user_profile/user_profile_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_event.dart';
import 'package:untitled1/blocs/user_profile/user_profile_state.dart';
import 'package:untitled1/data/local/storage_repository.dart';
import 'package:untitled1/screens/perevod/perevod_screen.dart';

import 'package:untitled1/screens/tab_box/card/card_screen.dart';
import 'package:untitled1/screens/tab_box/history/history_screen.dart';
import 'package:untitled1/screens/tab_box/home/home_screen.dart';
import 'package:untitled1/screens/tab_box/profile/profile_screen.dart';
import 'package:untitled1/screens/tab_box/tab_cubit/tab_box_cubit.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _screens = const [
    CardScreen(),
    PerevodScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    Future.microtask(() {
      context.read<UserProfileBloc>().add(GetUserProfileByUuIdEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBoxCubit(),
      child: BlocBuilder<TabBoxCubit, int>(
        builder: (BuildContext context, int state) {
          return Scaffold(
            body: Stack(
              children: [
                BlocListener<UserProfileBloc, UserProfileState>(
                  listener: (BuildContext context, UserProfileState state) {
                    if (state.statusMessage == "qonday") {
                      debugPrint("state.statusMessage == --------");
                      context.read<CardBloc>().add(CallCardsEvent());
                      context.read<CardBloc>().add(ListenUserCardsEvent(
                            docId: context
                                .read<UserProfileBloc>()
                                .state
                                .userModel
                                .userId,
                          ));
                    }
                  },
                  child: const SizedBox(),
                ),
                IndexedStack(
                  index: state,
                  children: _screens,
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state,
              onTap: context.read<TabBoxCubit>().changeValue,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.credit_card,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  label: "",
                  activeIcon: Icon(
                    Icons.credit_card,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.house,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  label: "",
                  activeIcon: Icon(
                    Icons.house,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  label: "",
                  activeIcon: Icon(
                    Icons.history,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  label: "",
                  activeIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
