class CardModel {
  final double balance;
  final String cardId;
  final String userId;
  final String cardNumber;
  final String cardSrok;
  final String type;
  final String bankName;
  final bool isMain;

  CardModel({
    required this.userId,
    required this.balance,
    required this.bankName,
    required this.cardId,
    required this.cardNumber,
    required this.cardSrok,
    required this.isMain,
    required this.type,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      balance: (json['balance'] as num? ?? 0.0).toDouble(),
      cardId: json['cardId'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      cardNumber: json['cardNumber'] as String? ?? "",
      cardSrok: json['cardSrok'] as String? ?? "",
      type: json['type'] as String? ?? "",
      bankName: json['bankName'] as String? ?? "",
      isMain: json['isMain'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'cardId': cardId,
      'userId': userId,
      'cardNumber': cardNumber,
      'cardSrok': cardSrok,
      'type': type,
      'bankName': bankName,
      'isMain': isMain,
    };
  }

  CardModel copyWith({
    double? balance,
    String? cardId,
    String? cardNumber,
    String? cardSrok,
    String? type,
    String? bankName,
    bool? isMain,
  }) {
    return CardModel(
      balance: balance ?? this.balance,
      cardId: cardId ?? this.cardId,
      userId: userId,
      cardNumber: cardNumber ?? this.cardNumber,
      cardSrok: cardSrok ?? this.cardSrok,
      type: type ?? this.type,
      bankName: bankName ?? this.bankName,
      isMain: isMain ?? this.isMain,
    );
  }

  static CardModel defaultCard() {
    return CardModel(
      userId: "",
      balance: 0.0,
      bankName: "",
      cardId: "",
      cardNumber: "",
      cardSrok: "",
      isMain: false,
      type: "",
    );
  }
}
