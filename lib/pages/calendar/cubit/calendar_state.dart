part of 'calendar_cubit.dart';

class CalendarState {
  const CalendarState({
    this.notes = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  final List<NoteModel> notes;
  final bool isLoading;
  final String errorMessage;

  CalendarState copyWith({
    List<NoteModel>? notes,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CalendarState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
