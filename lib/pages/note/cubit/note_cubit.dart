import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_calendar/model/note_model.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'note_state.dart';

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
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
        note: null,
      ));
    }
  }

  Future<void> deleteNote(String noteID) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
    ));

    try {
      await _notesRepository.deleteNote(noteID);

      emit(state.copyWith(
        isLoading: false,
        noteDeleted: true,
        errorMessage: null,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Błąd podczas usuwania notatki: ${error.toString()}',
        noteDeleted: false,
      ));
    }
  }
}
