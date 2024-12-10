import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_calendar/model/note_model.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._notesRepository) : super(const CalendarState());

  final NotesRepository _notesRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start([DateTime? selectedDate]) async {
    emit(
      const CalendarState(errorMessage: '', isLoading: true, notes: []),
    );

    _streamSubscription = _notesRepository.getNotesStream().listen((allNotes) {
      // Filtrowanie notatki dla konkretnej daty
      final filteredNotes = selectedDate != null
          ? allNotes.where((note) {
              return note.dateTime.year == selectedDate.year &&
                  note.dateTime.month == selectedDate.month &&
                  note.dateTime.day == selectedDate.day;
            }).toList()
          : allNotes;

      emit(
        CalendarState(
          notes: filteredNotes,
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
