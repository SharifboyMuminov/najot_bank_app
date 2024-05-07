import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/card/card_state.dart';
import 'package:untitled1/blocs/user_profile/user_profile_bloc.dart';
import 'package:untitled1/utils/size_utils.dart';

import '../../../blocs/card/card_bloc.dart';
import '../../../blocs/card/card_event.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<CardBloc>().add(ListenUserCardsEvent(
          userModel: context.read<UserProfileBloc>().state.userModel));
      context.read<CardBloc>().add(CallCardsEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (BuildContext context, CardState state) {
          // debugPrint("Qonday");
          return ListView(
            children: [
              ...List.generate(
                state.cards.length,
                (index) {
                  // debugPrint(state.cards[index].cardNumber);

                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.we, vertical: 10.he),
                    margin: EdgeInsets.symmetric(
                        vertical: 10.he, horizontal: 20.we),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 2.we),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.cards[index].bankName,
                          style: TextStyle(color: Colors.red, fontSize: 20.sp),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
