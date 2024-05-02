import 'package:equatable/equatable.dart';
import 'package:untitled1/data/models/user/user_model.dart';

abstract class UserProfileEvent extends Equatable {}

class AddUserProfileEvent extends UserProfileEvent {
  final UserModel userModel;

  AddUserProfileEvent({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class UpdateUserProfileEvent extends UserProfileEvent {
  final UserModel userModel;

  UpdateUserProfileEvent({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class DeleteUserProfileEvent extends UserProfileEvent {
  final UserModel userModel;

  DeleteUserProfileEvent({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class GetUserProfileByDocIdEvent extends UserProfileEvent {
  final UserModel userModel;

  GetUserProfileByDocIdEvent({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class GetUserProfileByUuIdEvent extends UserProfileEvent {
  @override
  List<Object?> get props => [];
}
