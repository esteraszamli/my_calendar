import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_calendar/core/error/error_handler.dart';
import 'package:my_calendar/models/holiday_model.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/repository/holiday_repository.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'calendar_cubit.freezed.dart';

@freezed
abstract class CalendarState with _$CalendarState {
  const factory CalendarState({
    @Default([]) List<NoteModel> notes,
    @Default([]) List<NoteModel> allNotes,
    @Default([]) List<HolidayModel> holidays,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    @Default(false) bool isNetworkError,
    DateTime? selectedDay,
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

    _currentSelectedDate = selectedDate;

    emit(state.copyWith(selectedDay: selectedDate));

    try {
      List<HolidayModel> holidays = state.holidays;

      final hasHolidaysForYear = state.holidays
          .any((h) => DateTime.parse(h.date).year == selectedYear);
      if (!hasHolidaysForYear) {
        emit(state.copyWith(isLoading: true));
        if (_holidayCache.containsKey(selectedYear)) {
          holidays = _holidayCache[selectedYear]!;
        } else {
          holidays = await _holidayRepository.getHolidays(selectedYear);
          _holidayCache[selectedYear] = holidays;
        }
      }

      if (_streamSubscription == null) {
        _streamSubscription = _notesRepository.getNotesStream().listen(
          (allNotes) {
            _updateStateWithNotes(allNotes, holidays);
          },
          onError: (error) {
            final handledException = ErrorHandler.handleError(error);
            emit(state.copyWith(
              errorMessage: handledException.message,
              isLoading: false,
              isNetworkError: handledException is NetworkException,
            ));
          },
        );
      } else {
        _updateStateWithNotes(state.allNotes, holidays);
      }
    } catch (error) {
      final handledException = ErrorHandler.handleError(error);
      emit(state.copyWith(
        errorMessage: handledException.message,
        isLoading: false,
        isNetworkError: handledException is NetworkException,
      ));
    }
  }

  void _updateStateWithNotes(
      List<NoteModel> allNotes, List<HolidayModel> holidays) {
    if (_currentSelectedDate == null) return;

    final filteredNotes = _getNotesForDate(allNotes, _currentSelectedDate!);

    final currentYear = _currentSelectedDate!.year;
    List<HolidayModel> allHolidays = List.from(state.holidays);

    if (holidays.isNotEmpty &&
        holidays.any((h) => DateTime.parse(h.date).year == currentYear)) {
      allHolidays
          .removeWhere((h) => DateTime.parse(h.date).year == currentYear);
      allHolidays.addAll(
          holidays.where((h) => DateTime.parse(h.date).year == currentYear));
    }

    emit(state.copyWith(
      notes: filteredNotes,
      allNotes: allNotes,
      holidays: allHolidays,
      isLoading: false,
      errorMessage: '',
      isNetworkError: false,
      selectedDay: _currentSelectedDate,
    ));
  }

  List<NoteModel> _getNotesForDate(List<NoteModel> allNotes, DateTime date) {
    return allNotes
        .where((note) =>
            note.dateTime.year == date.year &&
            note.dateTime.month == date.month &&
            note.dateTime.day == date.day)
        .toList();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
