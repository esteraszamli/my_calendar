part of 'calendar_cubit.dart';

class CalendarState {
  const CalendarState({
    this.notes = const [],
    this.holidays = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  final List<NoteModel> notes;
  final List<HolidayModel> holidays;
  final bool isLoading;
  final String errorMessage;

  CalendarState copyWith({
    List<NoteModel>? notes,
    List<HolidayModel>? holidays,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CalendarState(
      notes: notes ?? this.notes,
      holidays: holidays ?? this.holidays,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
