import 'package:flutter_bloc/flutter_bloc.dart';

class TabBoxCubit extends Cubit<int> {
  TabBoxCubit() : super(0);

  changeValue(int value) {
    emit(value);
  }
}