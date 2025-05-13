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
    @Default([]) List<NoteModel> allNotes,
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
  DateTime? _currentSelectedDate;

  final Map<int, List<HolidayModel>> _holidayCache = {};

  Future<void> start([DateTime? initialDate]) async {
    final selectedDate = initialDate ?? _currentSelectedDate ?? DateTime.now();
    final selectedYear = selectedDate.year;

    emit(state.copyWith(
      isLoading: true,
      errorMessage: '',
    ));

    try {
      // Pobieranie świąt z cache lub z repozytorium
      List<HolidayModel> holidays;
      if (_holidayCache.containsKey(selectedYear)) {
        holidays = _holidayCache[selectedYear]!;
      } else {
        holidays = await _holidayRepository.getHolidays(selectedYear);
        _holidayCache[selectedYear] = holidays;
      }

      if (_streamSubscription == null) {
        _streamSubscription = _notesRepository.getNotesStream().listen(
          (allNotes) {
            _updateNotes(allNotes, selectedDate, holidays);
          },
          onError: (error) {
            emit(state.copyWith(
              errorMessage: error.toString(),
              isLoading: false,
            ));
          },
        );
      } else {
        _updateNotes(state.allNotes, selectedDate, holidays);
      }

      _currentSelectedDate = selectedDate;
    } catch (error) {
      emit(state.copyWith(
        errorMessage: error.toString(),
        isLoading: false,
      ));
    }
  }

  void _updateNotes(List<NoteModel> allNotes, DateTime selectedDate,
      List<HolidayModel> holidays) {
    final filteredNotes = allNotes.where((note) {
      return note.dateTime.year == selectedDate.year &&
          note.dateTime.month == selectedDate.month &&
          note.dateTime.day == selectedDate.day;
    }).toList();

    emit(state.copyWith(
      notes: filteredNotes,
      allNotes: allNotes,
      holidays: holidays,
      isLoading: false,
      errorMessage: '',
    ));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
