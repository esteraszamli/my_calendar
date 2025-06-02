import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_calendar/core/error/error_handler.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/repository/notes_repository.dart';

part 'add_note_cubit.freezed.dart';

@freezed
abstract class AddNoteState with _$AddNoteState {
  const factory AddNoteState({
    @Default('') String title,
    @Default('') String content,
    required DateTime dateTime,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool noteAdded,
    @Default(false) bool savedLocally,
  }) = _AddNoteState;
}

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(
    this._notesRepository, {
    required DateTime initialDate,
  }) : super(AddNoteState(dateTime: initialDate));

  final NotesRepository _notesRepository;

  void updateField(String field, String value) {
    emit(state.copyWith(
      title: field == 'title' ? value : state.title,
      content: field == 'content' ? value : state.content,
    ));
  }

  Future<void> addNote() async {
    if (!_validateFields()) {
      _emitError('Uzupełnij wymagane pola');
      return;
    }
    _emitLoading();
    try {
      final note = _createNoteFromState();
      await _notesRepository.addNote(note);
      _emitSuccess(savedLocally: false);
    } catch (error) {
      final isNetworkError = ErrorHandler.isNetworkError(error);
      if (isNetworkError) {
        _emitSuccess(savedLocally: true);
      } else {
        final errorMessage = ErrorHandler.getErrorMessage(error);
        _emitError(errorMessage);
      }
    }
  }

  NoteModel _createNoteFromState() {
    return NoteModel(
      id: '',
      title: state.title.trim(),
      content: state.content.trim(),
      dateTime: state.dateTime,
      userID: '',
    );
  }

  void _emitLoading() {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      savedLocally: false,
    ));
  }

  void _emitSuccess({bool savedLocally = false}) {
    emit(state.copyWith(
      isLoading: false,
      noteAdded: true,
      errorMessage: null,
      savedLocally: savedLocally,
    ));
  }

  void _emitError(String message) {
    emit(state.copyWith(
      isLoading: false,
      errorMessage: message,
      savedLocally: false,
    ));
  }

  bool _validateFields() {
    final isValid = state.title.isNotEmpty && state.content.isNotEmpty;
    return isValid;
  }
}
