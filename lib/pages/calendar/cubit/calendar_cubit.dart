import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_calendar/models/holiday_model.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/repository/holiday_repository.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'calendar_cubit.freezed.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState({
    @Default([]) List<NoteModel> notes,
    @Default([]) List<HolidayModel> holidays,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _CalendarState;
}

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._notesRepository, this._holidayRepository)
      : super(const CalendarState());

  final NotesRepository _notesRepository;
  final HolidayRepository _holidayRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start([DateTime? selectedDate]) async {
    emit(
      state.copyWith(
        errorMessage: '',
        isLoading: true,
        notes: [],
        holidays: [],
      ),
    );

    try {
      final yearToFetch = (selectedDate ?? DateTime.now()).year;
      final holidays = await _holidayRepository.getHolidays(yearToFetch);

      await _streamSubscription?.cancel();

      _streamSubscription = _notesRepository.getNotesStream().listen(
        (allNotes) {
          final filteredNotes = selectedDate != null
              ? allNotes.where((note) {
                  return note.dateTime.year == selectedDate.year &&
                      note.dateTime.month == selectedDate.month &&
                      note.dateTime.day == selectedDate.day;
                }).toList()
              : allNotes;

          emit(
            state.copyWith(
              notes: filteredNotes,
              holidays: holidays,
              isLoading: false,
              errorMessage: '',
            ),
          );
        },
        onError: (error) {
          emit(
            state.copyWith(
              errorMessage: error.toString(),
            ),
          );
        },
      );
    } catch (error) {
      emit(
        state.copyWith(
          errorMessage: error.toString(),
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
