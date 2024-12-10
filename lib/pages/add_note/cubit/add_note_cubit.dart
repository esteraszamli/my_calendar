import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(
    this._notesRepository, {
    required DateTime initialDate,
  }) : super(AddNoteState(
          title: '',
          content: '',
          dateTime: initialDate,
        ));

  final NotesRepository _notesRepository;

  void updateField(String field, String value) {
    emit(state.copyWith(
      title: field == 'title' ? value : null,
      content: field == 'content' ? value : null,
    ));
  }

  Future<void> addNote() async {
    if (!_validateFields()) {
      emit(state.copyWith(
        errorMessage: 'Uzupełnij wymagane pola',
        isLoading: false,
      ));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final note = NoteModel(
        id: '',
        title: state.title.trim(),
        content: state.content.trim(),
        dateTime: state.dateTime,
        userID: '',
      );

      await _notesRepository.addNote(note);

      emit(state.copyWith(
        isLoading: false,
        noteAdded: true,
        errorMessage: null,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Błąd podczas dodawania notatki: ${error.toString()}',
      ));
    }
  }

  bool _validateFields() {
    return state.title.isNotEmpty && state.content.isNotEmpty;
  }
}
