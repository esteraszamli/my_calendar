import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_calendar/models/holiday_model.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/repository/holiday_repository.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._notesRepository, this._holidayRepository)
      : super(const CalendarState());

  final NotesRepository _notesRepository;
  final HolidayRepository _holidayRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start([DateTime? selectedDate]) async {
    emit(
      CalendarState(
        errorMessage: '',
        isLoading: true,
        notes: [],
        holidays: [],
      ),
    );

    try {
      // Pobierz dni wolne dla roku
      final yearToFetch = (selectedDate ?? DateTime.now()).year;
      final holidays = await _holidayRepository.getHolidays(yearToFetch);

      // Anuluj poprzednią subskrypcję, jeśli istnieje
      await _streamSubscription?.cancel();

      // Nowa subskrypcja strumienia notatek
      _streamSubscription =
          _notesRepository.getNotesStream().listen((allNotes) {
        // Filtrowanie notatek dla konkretnej daty
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
            holidays: holidays,
            isLoading: false,
            errorMessage: '',
          ),
        );
      }, onError: (error) {
        emit(
          CalendarState(
            errorMessage: error.toString(),
            notes: state.notes,
            holidays: state.holidays,
          ),
        );
      });
    } catch (error) {
      emit(
        CalendarState(
          errorMessage: error.toString(),
          notes: state.notes,
          holidays: state.holidays,
          isLoading: false,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
