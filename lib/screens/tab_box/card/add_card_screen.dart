import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/blocs/card/card_bloc.dart';
import 'package:untitled1/blocs/card/card_event.dart';
import 'package:untitled1/blocs/user_profile/user_profile_bloc.dart';
import 'package:untitled1/screens/widget/save_button.dart';
import 'package:untitled1/utils/size_utils.dart';

import '../../../data/models/card/card_model.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController numberCardController = TextEditingController();
  TextEditingController srokCardController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.we, vertical: 30.he),
        child: Column(
          children: [
            TextFormField(
              maxLength: 16,
              controller: numberCardController,
            ),
            TextFormField(
              maxLength: 5,
              controller: srokCardController,
            ),
            SizedBox(height: 50.he),
            SaveButton(
              onTab: () {
                if (numberCardController.text.length == 16 &&
                    srokCardController.text.length == 5) {
                  List<CardModel> myCards =
                      context.read<CardBloc>().state.userCards;
                  List<CardModel> cards = context.read<CardBloc>().state.cards;
                  for (int i = 0; i < myCards.length; i++) {
                    if (myCards[i].cardNumber == numberCardController.text) {
                      numberCardController.clear();
                      srokCardController.clear();
                      return;
                    }
                  }

                  CardModel newCard = CardModel.defaultCard();

                  for (int i = 0; i < cards.length; i++) {
                    debugPrint(cards[i].cardNumber);
                    if (cards[i].cardNumber == numberCardController.text &&
                        srokCardController.text == cards[i].cardSrok) {
                      context.read<CardBloc>().add(
                            AddCardStateEvent(
                              cardModel: cards[i].copyWith(
                                  userId: context
                                      .read<UserProfileBloc>()
                                      .state
                                      .userModel
                                      .userId),
                            ),
                          );
                      numberCardController.clear();
                      srokCardController.clear();
                      return;
                    }
                  }
                }

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("No Card :(")));
              },
              loading: loading,
              active: true,
            ),
          ],
        ),
      ),
    );
  }
}
