part of 'edit_note_cubit.dart';

class EditNoteState {
  final String id;
  final String title;
  final String content;
  final DateTime dateTime;
  final String userID;
  final bool isLoading;
  final String? errorMessage;
  final bool noteUpdated;

  EditNoteState({
    required this.id,
    this.title = '',
    this.content = '',
    required this.dateTime,
    required this.userID,
    this.isLoading = false,
    this.errorMessage,
    this.noteUpdated = false,
  });

  // Tworzenie stanu z istniejącego przepisu
  factory EditNoteState.fromNote(NoteModel note) {
    return EditNoteState(
      id: note.id,
      title: note.title,
      content: note.content,
      dateTime: note.dateTime,
      userID: note.userID,
    );
  }

  EditNoteState copyWith({
    String? title,
    String? content,
    bool? isLoading,
    String? errorMessage,
    bool? noteUpdated,
  }) {
    return EditNoteState(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      dateTime: dateTime,
      userID: userID,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      noteUpdated: noteUpdated ?? this.noteUpdated,
    );
  }
}
