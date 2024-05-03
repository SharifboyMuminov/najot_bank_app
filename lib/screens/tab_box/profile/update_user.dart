import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_event.dart';
import 'package:untitled1/data/models/user/user_model.dart';
import 'package:untitled1/screens/auth/widgets/save_button.dart';
import 'package:untitled1/screens/auth/widgets/universal_text_input.dart';
import 'package:untitled1/utils/app_contains.dart';
import 'package:untitled1/utils/size_utils.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late UserModel userModel;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  void initState() {
    userModel = widget.userModel;
    emailController.text = userModel.email;
    fullNameController.text = "${userModel.userName} ${userModel.lastName}";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 90.he,
              width: width,
            ),
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
                  image: userModel.imageUrl.isEmpty
                      ? const AssetImage("assets/images/profile.png")
                      : NetworkImage(userModel.imageUrl) as ImageProvider,
                ),
              ),
            ),
            SizedBox(height: 20.he),
            UniversalTextInput(
              controller: emailController,
              hintText: "Email",
              type: TextInputType.emailAddress,
              regExp: AppConstants.emailRegExp,
              onChange: (v) {
                setState(() {});
              },
              errorTitle: "Invalid input",
            ),
            UniversalTextInput(
              controller: fullNameController,
              hintText: "Full name",
              type: TextInputType.emailAddress,
              regExp: AppConstants.textRegExp,
              onChange: (v) {
                setState(() {});
              },
              errorTitle: "Invalid input",
            ),
            SaveButton(
              onTab: () {
                context
                    .read<UserProfileBloc>()
                    .add(UpdateUserProfileEvent(userModel: userModel));
                Navigator.pop(context);
              },
              active: checkInput,
              loading: false,
            ),
          ],
        ),
      ),
    );
  }

  bool get checkInput {
    return AppConstants.emailRegExp.hasMatch(emailController.text) &&
        AppConstants.textRegExp.hasMatch(fullNameController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();

    super.dispose();
  }
}
