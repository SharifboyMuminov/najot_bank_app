import 'package:equatable/equatable.dart';
import 'package:untitled1/data/models/user/user_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.password, required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [password, email];
}

class AuthRegisterEvent extends AuthEvent {
  final UserModel userModel;

  AuthRegisterEvent({required this.userModel});

  @override
  // TODO: implement props
  List<Object?> get props => [userModel];
}

class AuthSignOutEvent extends AuthEvent {}

class AuthLogOutEvent extends AuthEvent {}

class AuthCheckEvent extends AuthEvent {}
