import 'package:equatable/equatable.dart';
import 'package:untitled1/data/models/card/card_model.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/data/models/user/user_model.dart';

class CardState extends Equatable {
  final String errorText;
  final String statusMessage;
  final FormStatus formStatus;
  final List<CardModel> cards;
  final List<CardModel> userCards;

  const CardState({
    required this.userCards,
    required this.cards,
    required this.formStatus,
    required this.errorText,
    required this.statusMessage,
  });

  CardState copyWith({
    String? errorText,
    String? statusMessage,
    FormStatus? formStatus,
    List<CardModel>? cards,
    List<CardModel>? userCards,
  }) {
    return CardState(
      formStatus: formStatus ?? this.formStatus,
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
      userCards: userCards ?? this.userCards,
      cards: cards ?? this.cards,
    );
  }

  @override
  List<Object?> get props =>
      [userCards, cards, errorText, formStatus, statusMessage];
}
