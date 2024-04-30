import 'package:banking_app/blocs/connectivity/connectivity_bloc.dart';
import 'package:banking_app/blocs/connectivity/connectivity_state.dart';
import 'package:banking_app/utils/app_colors.dart';
import 'package:banking_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key, required this.onInternetComeBack})
      : super(key: key);
  final VoidCallback onInternetComeBack;

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        debugPrint("ON POP INVOKED:$value");
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "NO INTERNET",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 32.w,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            BlocListener<ConnectivityBloc, ConnectivityState>(
              listener: (context, state) {
                if (state.hasInternet) {
                  widget.onInternetComeBack.call();
                  Navigator.pop(context);
                }
              },
              child: const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
