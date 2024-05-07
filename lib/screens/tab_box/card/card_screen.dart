import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/card/card_state.dart';
import 'package:untitled1/blocs/user_profile/user_profile_bloc.dart';
import 'package:untitled1/data/local/storage_repository.dart';
import 'package:untitled1/screens/tab_box/card/add_card_screen.dart';
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
      context.read<CardBloc>().add(CallCardsEvent());
      context.read<CardBloc>().add(ListenUserCardsEvent(
          docId: StorageRepository.getString(key: "docId")));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddCardScreen();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.add,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (BuildContext context, CardState state) {
          // debugPrint("Qonday");
          if (state.userCards.isEmpty) {
            return Center(child: Icon(Icons.eight_mp_outlined, size: 50.sp));
          }
          return ListView.builder(
            itemCount: state.userCards.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 20.we, vertical: 10.he),
                padding:
                    EdgeInsets.symmetric(horizontal: 10.we, vertical: 10.he),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 2.we),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Text(
                      state.cards[index].bankName,
                      style: TextStyle(color: Colors.red, fontSize: 20.sp),
                    ),
                    Text(
                      state.cards[index].cardNumber,
                      style: TextStyle(color: Colors.red, fontSize: 20.sp),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
