import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_state.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/screens/routes.dart';
import 'package:untitled1/utils/size_utils.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.updateUser,
                  arguments: context.read<UserProfileBloc>().state.userModel);
            },
            icon: Icon(
              Icons.settings,
              size: 24.sp,
            ),
          ),
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
              SizedBox(height: 20.he),
              Container(
                width: 150.we,
                height: 150.we,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 3),
                  ],
                  image: DecorationImage(
                    image: state.userModel.imageUrl.isEmpty
                        ? const AssetImage("assets/images/profile.png")
                        : NetworkImage(state.userModel.imageUrl)
                            as ImageProvider,
                  ),
                ),
              ),
              SizedBox(height: 10.he),
              Text(
                "${state.userModel.lastName} ${state.userModel.userName}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.he),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10.we, right: 10.we, top: 30.he),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 3),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: double.infinity),
                        Text(
                          "Email: ${state.userModel.email}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.he),
                        Text(
                          "Last name: ${state.userModel.lastName}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.he),
                        Text(
                          "First name: ${state.userModel.userName}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.he),
                        Text(
                          "Phone number: ${state.userModel.phoneNumber}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        listener: (BuildContext context, UserProfileState state) {},
      ),
    );
  }
}
