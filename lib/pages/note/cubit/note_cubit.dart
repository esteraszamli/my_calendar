import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_calendar/core/error/error_handler.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'note_cubit.freezed.dart';

@freezed
abstract class NoteState with _$NoteState {
  const factory NoteState({
    NoteModel? note,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool noteDeleted,
    @Default(false) bool noteUpdated,
    @Default(false) bool noteDeletedLocally,
  }) = _NoteState;
}

class NoteCubit extends Cubit<NoteState> {
  NoteCubit(this._notesRepository) : super(const NoteState());

  final NotesRepository _notesRepository;

  Future<void> getNoteDetails(String noteID) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
    ));

    try {
      final note = await _notesRepository.getNoteById(noteID);

      emit(state.copyWith(
        note: note,
        isLoading: false,
        errorMessage: null,
      ));
    } catch (error) {
      final errorMessage = ErrorHandler.getErrorMessage(error);

      emit(state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
        note: null,
      ));
    }
  }

  void markAsUpdated() {
    emit(state.copyWith(noteUpdated: true));
  }

  Future<void> deleteNote(String noteID) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      noteDeletedLocally: false,
    ));

    try {
      await _notesRepository.deleteNote(noteID);

      emit(state.copyWith(
        isLoading: false,
        noteDeleted: true,
        errorMessage: null,
        noteDeletedLocally: false,
      ));
    } catch (error) {
      // Sprawdź czy to błąd sieciowy
      if (ErrorHandler.isNetworkError(error)) {
        // Jeśli to błąd sieciowy, oznacz jako usunięte lokalnie
        emit(state.copyWith(
          isLoading: false,
          noteDeleted: false,
          errorMessage: null,
          noteDeletedLocally: true, // Flagę dla lokalnego usunięcia
        ));
      } else {
        // Dla innych błędów pokaż normalny komunikat błędu
        final errorMessage = ErrorHandler.getErrorMessage(error);
        emit(state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
          noteDeleted: false,
          noteDeletedLocally: false,
        ));
      }
    }
  }
}
