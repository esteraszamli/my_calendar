import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'edit_note_cubit.freezed.dart';

@freezed
class EditNoteState with _$EditNoteState {
  const factory EditNoteState({
    required String id,
    @Default('') String title,
    @Default('') String content,
    required DateTime dateTime,
    required String userID,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool noteUpdated,
  }) = _EditNoteState;

  // Fabryka do tworzenia stanu z istniejącej notatki
  factory EditNoteState.fromNote(NoteModel note) => EditNoteState(
        id: note.id,
        title: note.title,
        content: note.content,
        dateTime: note.dateTime,
        userID: note.userID,
      );
}

class EditNoteCubit extends Cubit<EditNoteState> {
  final NotesRepository _notesRepository;

  EditNoteCubit(this._notesRepository, NoteModel note)
      : super(EditNoteState.fromNote(note));

  void updateField(String field, String value) {
    emit(state.copyWith(
      title: field == 'title' ? value : state.title,
      content: field == 'content' ? value : state.content,
    ));
  }

  Future<void> updateNote() async {
    if (!_validateFields()) {
      emit(state.copyWith(
        errorMessage: 'Uzupełnij wymagane pola',
        isLoading: false,
      ));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final updatedNote = NoteModel(
        id: state.id.trim(),
        title: state.title.trim(),
        content: state.content.trim(),
        dateTime: state.dateTime,
        userID: state.userID,
      );

      await _notesRepository.updateNote(updatedNote);

      emit(state.copyWith(
        isLoading: false,
        noteUpdated: true,
        errorMessage: null,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Błąd podczas edycji: ${error.toString()}',
      ));
    }
  }

  bool _validateFields() {
    return state.title.isNotEmpty && state.content.isNotEmpty;
  }
}
