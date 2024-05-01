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
  }

  Future<void> _login(AuthLoginEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.loginWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    _result(networkResponse, emit);
  }

  Future<void> _register(AuthRegisterEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await authRepository.registerWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    _result(networkResponse, emit);
  }

  _result(NetworkResponse networkResponse, emit) {
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
}
