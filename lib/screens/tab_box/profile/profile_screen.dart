import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_state.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/screens/routes.dart';

import '../../../blocs/auth/auth_event.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authRoute, (route) => false);
              context.read<AuthBloc>().add(AuthLogOutEvent());
            },
            icon: Icon(
              Icons.exit_to_app,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        builder: (BuildContext context, UserProfileState state) {
          return Column(
            children: [
              Text(
                state.userModel.email,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp,
                ),
              ),
            ],
          );
        },
        listener: (BuildContext context, UserProfileState state) {
          if (state.formStatus == FormStatus.success) {
            setState(() {});
          }
        },
      ),
    );
  }
}
