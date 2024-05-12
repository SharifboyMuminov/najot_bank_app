class HistoryModel {
  final String docId;
  final String senderUserDocId;
  final double money;
  final String receptiveUserName;

  HistoryModel({
    required this.docId,
    required this.money,
    required this.receptiveUserName,
    required this.senderUserDocId,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      docId: json['docId'],
      senderUserDocId: json['senderUserDocId'],
      money: json['money'].toDouble(),
      receptiveUserName: json['receptiveUserName'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'senderUserDocId': senderUserDocId,
      'money': money,
      'receptiveUserName': receptiveUserName,
    };
  }

  HistoryModel copyWith({
    String? docId,
    String? senderUserDocId,
    double? money,
    String? receptiveUserName,
  }) {
    return HistoryModel(
      docId: docId ?? this.docId,
      senderUserDocId: senderUserDocId ?? this.senderUserDocId,
      money: money ?? this.money,
      receptiveUserName: receptiveUserName ?? this.receptiveUserName,
    );
  }
}
