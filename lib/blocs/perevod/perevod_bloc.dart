import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/blocs/perevod/perevod_event.dart';
import 'package:untitled1/blocs/perevod/perevod_state.dart';

class PerevodBloc extends Bloc<PerevodEvent, PerevodState> {
  PerevodBloc()
      : super(
          PerevodState(
            errorText: "",
            history: [],
            statusMessage: "",
          ),
        ) {
    on<PerevodCallHistoryEvent>(_perevodCallHistoryEvent);
    on<PerevodMoneyEvent>(_perevodMoneyEvent);
    on<PerevodValidateEvent>(_perevodValidateEvent);
  }

  _perevodCallHistoryEvent(PerevodCallHistoryEvent event, emit) {}

  _perevodMoneyEvent(PerevodMoneyEvent event, emit) {}

  _perevodValidateEvent(PerevodValidateEvent event, emit) {}
}
