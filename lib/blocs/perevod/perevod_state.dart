import 'package:untitled1/data/models/history/history_model.dart';

class PerevodState {
  final String errorText;
  final String statusMessage;
  final List<HistoryModel> history;

  PerevodState({
    required this.errorText,
    required this.history,
    required this.statusMessage,
  });

  PerevodState copyWithe({
    String? errorText,
    String? statusMessage,
    List<HistoryModel>? history,
  }) {
    return PerevodState(
      errorText: errorText ?? this.errorText,
      history: history ?? this.history,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}
