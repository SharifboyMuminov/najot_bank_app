import 'package:equatable/equatable.dart';
import 'package:untitled1/data/models/card/card_model.dart';
import 'package:untitled1/data/models/user/user_model.dart';

abstract class CardEvent extends Equatable {}

class AddCardStateEvent extends CardEvent {
  final CardModel cardModel;

  AddCardStateEvent({required this.cardModel});

  @override
  List<Object?> get props => [cardModel];
}

class DeleteCardEvent extends CardEvent {
  final CardModel cardModel;

  DeleteCardEvent({required this.cardModel});

  @override
  List<Object?> get props => [cardModel];
}

class UpdateCardEvent extends CardEvent {
  final CardModel cardModel;

  UpdateCardEvent({required this.cardModel});

  @override
  List<Object?> get props => [cardModel];
}

class ListenUserCardsEvent extends CardEvent {
  final String docId;

  ListenUserCardsEvent({required this.docId});

  @override
  List<Object?> get props => [];
}

class CallCardsEvent extends CardEvent {
  @override
  List<Object?> get props => [];
}
