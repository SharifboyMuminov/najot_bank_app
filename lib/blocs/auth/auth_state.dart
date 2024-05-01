import 'package:equatable/equatable.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';

class AuthState extends Equatable {
  final String errorMessage;
  final String statusMessage;
  final FormStatus formStatus;

  const AuthState({
    required this.formStatus,
    required this.errorMessage,
    required this.statusMessage,
  });

  AuthState copyWith({
    String? errorMessage,
    String? statusMessage,
    FormStatus? formStatus,
  }) {
    return AuthState(
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [formStatus, errorMessage, statusMessage];
}
