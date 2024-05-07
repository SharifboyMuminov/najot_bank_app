import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/blocs/card/card_event.dart';
import 'package:untitled1/blocs/card/card_state.dart';
import 'package:untitled1/blocs/user_profile/user_profile_event.dart';
import 'package:untitled1/blocs/user_profile/user_profile_state.dart';
import 'package:untitled1/data/models/card/card_model.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/data/models/network_response.dart';
import 'package:untitled1/data/models/user/user_model.dart';
import 'package:untitled1/data/repository/card_repository.dart';
import 'package:untitled1/data/repository/user_repository.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc(this.cardRepository)
      : super(
          const CardState(
            userCards: [],
            cards: [],
            formStatus: FormStatus.pure,
            errorText: "",
            statusMessage: "",
          ),
        ) {
    on<AddCardStateEvent>(_addCard);
    on<DeleteCardEvent>(_deleteCard);
    on<UpdateCardEvent>(_updateCard);
    on<CallCardsEvent>(_listenCardData);
    on<ListenUserCardsEvent>(_listenCardUser);
  }

  final CardRepository cardRepository;

  Future<void> _addCard(AddCardStateEvent event, emit) async {
    NetworkResponse networkResponse = NetworkResponse();

    emit(state.copyWith(formStatus: FormStatus.loading));

    networkResponse =
        await cardRepository.insertCard(cardModel: event.cardModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(formStatus: FormStatus.error));
    }
  }

  Future<void> _deleteCard(DeleteCardEvent event, emit) async {
    NetworkResponse networkResponse = NetworkResponse();

    emit(state.copyWith(formStatus: FormStatus.loading));

    networkResponse =
        await cardRepository.deleteCard(cardModel: event.cardModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(formStatus: FormStatus.error));
    }
  }

  Future<void> _updateCard(UpdateCardEvent event, emit) async {
    NetworkResponse networkResponse = NetworkResponse();

    emit(state.copyWith(formStatus: FormStatus.loading));

    networkResponse =
        await cardRepository.updateCard(cardModel: event.cardModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(formStatus: FormStatus.error));
    }
  }

  _listenCardUser(ListenUserCardsEvent event, Emitter emit) async {
    await emit
        .onEach(cardRepository.getCardByUserId(userId: event.userModel.userId),
            onData: (List<CardModel> userCards) {
      emit(state.copyWith(userCards: userCards));
    });
  }

  _listenCardData(CallCardsEvent event, Emitter emit) async {
    await emit.onEach(cardRepository.getCardsData(),
        onData: (List<CardModel> cards) {
      emit(state.copyWith(cards: cards));
    });
  }
}
