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
    @Default(false) bool isNetworkError,
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
      emit(state.copyWith(
        errorMessage: 'Uzupełnij wymagane pola',
        isLoading: false,
        isNetworkError: false,
      ));
      return;
    }

    try {
      emit(state.copyWith(
        isLoading: true,
        errorMessage: null,
        isNetworkError: false,
      ));

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
        isNetworkError: false,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandler.getErrorMessage(error),
        isNetworkError: ErrorHandler.isNetworkError(error),
      ));
    }
  }

  bool _validateFields() {
    return state.title.isNotEmpty && state.content.isNotEmpty;
  }
}
