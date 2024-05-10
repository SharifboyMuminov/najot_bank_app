import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/card/card_state.dart';
import 'package:untitled1/data/local/storage_repository.dart';
import 'package:untitled1/screens/tab_box/card/add_card_screen.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/size_utils.dart';

import '../../../blocs/card/card_bloc.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {

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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.he),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.userCards[index].type,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 36.w,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Platinum",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.w,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        state.userCards[index].cardNumber,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24.w,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
