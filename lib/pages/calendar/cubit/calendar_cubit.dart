import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_calendar/model/note_model.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._notesRepository) : super(const CalendarState());

  final NotesRepository _notesRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const CalendarState(errorMessage: '', isLoading: true, notes: []),
    );

    _streamSubscription = _notesRepository.getNotesStream().listen((data) {
      emit(
        CalendarState(
          notes: data,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          CalendarState(
            errorMessage: error.toString(),
            notes: state.notes,
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
