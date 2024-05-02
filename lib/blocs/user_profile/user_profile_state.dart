import 'package:equatable/equatable.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/data/models/user/user_model.dart';

class UserProfileState extends Equatable {
  final String errorText;
  final String statusMessage;
  final FormStatus formStatus;
  final UserModel userModel;

  const UserProfileState({
    required this.userModel,
    required this.formStatus,
    required this.errorText,
    required this.statusMessage,
  });

  UserProfileState copyWith({
    String? errorText,
    String? statusMessage,
    FormStatus? formStatus,
    UserModel? userModel,
  }) {
    return UserProfileState(
      userModel: userModel ?? this.userModel,
      formStatus: formStatus ?? this.formStatus,
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [userModel, errorText, formStatus, statusMessage];
}
