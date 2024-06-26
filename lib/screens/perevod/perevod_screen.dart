import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/blocs/card/card_bloc.dart';
import 'package:untitled1/blocs/card/card_event.dart';
import 'package:untitled1/data/models/card/card_model.dart';
import 'package:untitled1/screens/widget/app_input_formatters.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/size_utils.dart';

import '../../blocs/card/card_state.dart';
import '../widget/card_input.dart';

class PerevodScreen extends StatefulWidget {
  const PerevodScreen({super.key});

  @override
  State<PerevodScreen> createState() => _PerevodScreenState();
}

class _PerevodScreenState extends State<PerevodScreen> {
  TextEditingController controllerCardNumbers = TextEditingController();
  TextEditingController controllerMoney = TextEditingController();

  CardModel myCard = CardModel.defaultCard();
  CardModel toCard = CardModel.defaultCard();

  bool showMoneyInput = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perevod Screen",
          style: TextStyle(
            color: Colors.black,
            fontSize: 23.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30.he),
        child: Column(
          children: [
            CardInputMyTextField(
              maskTextInputFormatter: AppInputFormatters.cardNumberFormatter,
              controller: controllerCardNumbers,
              onChanged: (String value) {
                String cardNumber = value.replaceAll(" ", "");
                if (cardNumber.length == 16) {
                  List<CardModel> cards = context.read<CardBloc>().state.cards;

                  for (CardModel cad in cards) {
                    if (cad.cardNumber == cardNumber) {
                      if (myCard.cardNumber == cad.cardNumber) {
                        // debugPrint("Qonday");
                        break;
                      } else {
                        toCard = cad;
                        showMoneyInput = true;
                        setState(() {});
                        return;
                      }
                    }
                  }
                  showMoneyInput = false;
                  setState(() {});

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "No card :(",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20.he),
            if (showMoneyInput)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.we),
                child: TextFormField(
                  controller: controllerMoney,
                  maxLength: null,
                  onChanged: (v) {
                    setState(() {});
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  inputFormatters: [AppInputFormatters.money],
                  decoration: InputDecoration(
                    hintText: "Money...",
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.we, vertical: 15.he),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.black, width: 2.we),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.black, width: 1.we),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 50.he),
            BlocBuilder<CardBloc, CardState>(
              builder: (BuildContext context, CardState state) {
                // debugPrint("Qonday");
                if (state.userCards.isEmpty) {
                  return Center(
                      child: Icon(Icons.eight_mp_outlined, size: 50.sp));
                }
                return SizedBox(
                  height: 200.he,
                  child: PageView(
                    onPageChanged: (v) {
                      myCard = context.read<CardBloc>().state.userCards[v];
                    },
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      state.userCards.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10.he),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h),
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
                                  state.userCards[index].balance.toString(),
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
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.we, vertical: 10.he),
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: _validate ? Colors.blue : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: _validate
                    ? () {
                        context.read<CardBloc>().add(
                              PerevodMoneyEvent(
                                toCard: toCard,
                                myCard: myCard,
                                money: double.parse(
                                  controllerMoney.text.replaceAll(' ', ""),
                                ),
                              ),
                            );
                        controllerCardNumbers.clear();
                        controllerMoney.clear();
                        myCard = CardModel.defaultCard();
                        toCard = CardModel.defaultCard();

                        bool showMoneyInput = false;

                        setState(() {});
                      }
                    : null,
                child: Text(
                  "Ok",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _validate {
    return myCard.cardNumber.isNotEmpty &&
        toCard.cardNumber.isNotEmpty &&
        controllerMoney.text.isNotEmpty;
  }
}
