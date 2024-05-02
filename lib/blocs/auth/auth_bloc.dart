import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/blocs/auth/auth_event.dart';
import 'package:untitled1/blocs/auth/auth_state.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/data/models/network_response.dart';
import 'package:untitled1/data/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository})
      : super(
          const AuthState(
            formStatus: FormStatus.pure,
            errorMessage: "",
            statusMessage: "",
          ),
        ) {
    on<AuthLoginEvent>(_login);
    on<AuthRegisterEvent>(_register);
    on<AuthCheckEvent>(_checkAuth);
    on<AuthLogOutEvent>(_logOutUser);
  }

  Future<void> _logOutUser(AuthLogOutEvent event, emit) async {
    await authRepository.logOutUser();
  }

  Future<void> _login(AuthLoginEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.loginWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
        formStatus: FormStatus.authenticated,
      ));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.unauthenticated,
          errorMessage: networkResponse.errorText));
    }
  }

  Future<void> _register(AuthRegisterEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.registerWithEmailAndPassword(
      email: event.userModel.email,
      password: event.userModel.password,
    );
    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
        formStatus: FormStatus.authenticated,
      ));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.unauthenticated,
          errorMessage: networkResponse.errorText));
    }
  }

  Future<void> _checkAuth(AuthCheckEvent event, emit) async {
    NetworkResponse networkResponse = await authRepository.checkUser();
    // User? user = networkResponse.data;
    // if (user != null) {
    //   debugPrint(user.email);
    // } else {
    //   debugPrint("Nullllllllll");
    // }

    if (networkResponse.data != null) {
      emit(state.copyWith(
        formStatus: FormStatus.authenticated,
      ));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.unauthenticated,
          errorMessage: networkResponse.errorText));
    }
  }
}
