import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/blocs/user_profile/user_profile_event.dart';
import 'package:untitled1/blocs/user_profile/user_profile_state.dart';
import 'package:untitled1/data/models/from_status/from_status_enum.dart';
import 'package:untitled1/data/models/network_response.dart';
import 'package:untitled1/data/models/user/user_model.dart';
import 'package:untitled1/data/repository/user_repository.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(this.userRepository)
      : super(
          UserProfileState(
            userModel: UserModel.initial(),
            formStatus: FormStatus.pure,
            errorText: "",
            statusMessage: "",
          ),
        ) {
    on<AddUserProfileEvent>(_addUser);

    on<DeleteUserProfileEvent>(_deleteUser);

    on<UpdateUserProfileEvent>(_updateUser);

    on<GetUserProfileByDocIdEvent>(_getUserByDocId);

    on<GetUserProfileByUuIdEvent>(_getUserByUuId);
  }

  final UserRepository userRepository;

  Future<void> _addUser(AddUserProfileEvent event, emit) async {
    // debugPrint("_addUser------");

    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userRepository.insertUser(userModel: event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error, errorText: networkResponse.errorText));
    }
  }

  Future<void> _deleteUser(DeleteUserProfileEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userRepository.deleteUser(userModel: event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.unauthenticated));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error, errorText: networkResponse.errorText));
    }
  }

  Future<void> _updateUser(UpdateUserProfileEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userRepository.updateUser(userModel: event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error, errorText: networkResponse.errorText));
    }
  }

  Future<void> _getUserByDocId(GetUserProfileByDocIdEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse =
        await userRepository.getUserByDocId(docId: event.userModel.userId);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.unauthenticated));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error, errorText: networkResponse.errorText));
    }
  }

  Future<void> _getUserByUuId(GetUserProfileByUuIdEvent event, emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    NetworkResponse networkResponse = await userRepository.getUserByUuId();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormStatus.error, errorText: networkResponse.errorText));
    }
  }
}
