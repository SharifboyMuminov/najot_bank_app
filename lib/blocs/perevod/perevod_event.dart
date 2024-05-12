import 'package:untitled1/data/models/card/card_model.dart';

abstract class PerevodEvent {}

class PerevodCallHistoryEvent extends PerevodEvent {}

class PerevodValidateEvent extends PerevodEvent {
  final String cardNumber;
  final double money;

  PerevodValidateEvent({
    required this.money,
    required this.cardNumber,
  });
}

class PerevodMoneyEvent extends PerevodEvent {
  final CardModel myCard;
  final CardModel toCard;
  final double money;

  PerevodMoneyEvent({
    required this.money,
    required this.myCard,
    required this.toCard,
  });
}
