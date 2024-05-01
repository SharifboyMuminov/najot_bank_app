import 'package:equatable/equatable.dart';

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
  final String email;
  final String password;

  AuthRegisterEvent({required this.password, required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [password, email];
}

class AuthSignOutUserEvent extends AuthEvent {}
