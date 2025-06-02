import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_calendar/core/error/error_handler.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'edit_note_cubit.freezed.dart';

@freezed
abstract class EditNoteState with _$EditNoteState {
  const factory EditNoteState({
    required String id,
    @Default('') String title,
    @Default('') String content,
    required DateTime dateTime,
    required String userID,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool noteUpdated,
    @Default(false) bool updatedLocally,
  }) = _EditNoteState;

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
      _emitError('Uzupełnij wymagane pola');
      return;
    }
    _emitLoading();

    try {
      final updatedNote = _createNoteFromState();
      await _notesRepository.updateNote(updatedNote);
      _emitSuccess(updatedLocally: false);
    } catch (error) {
      final errorMessage = ErrorHandler.getErrorMessage(error);
      final isNetworkError = ErrorHandler.isNetworkError(error);

      if (isNetworkError) {
        _emitSuccess(updatedLocally: true);
      } else {
        _emitError(errorMessage);
      }
    }
  }

  NoteModel _createNoteFromState() {
    return NoteModel(
      id: state.id.trim(),
      title: state.title.trim(),
      content: state.content.trim(),
      dateTime: state.dateTime,
      userID: state.userID,
    );
  }

  void _emitLoading() {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      updatedLocally: false,
    ));
  }

  void _emitSuccess({bool updatedLocally = false}) {
    emit(state.copyWith(
      isLoading: false,
      noteUpdated: true,
      errorMessage: null,
      updatedLocally: updatedLocally,
    ));
  }

  void _emitError(String message) {
    emit(state.copyWith(
      isLoading: false,
      errorMessage: message,
      updatedLocally: false,
    ));
  }

  bool _validateFields() {
    return state.title.isNotEmpty && state.content.isNotEmpty;
  }
}
