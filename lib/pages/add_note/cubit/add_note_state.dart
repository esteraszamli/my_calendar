part of 'add_note_cubit.dart';

class AddNoteState {
  final String title;
  final String content;
  final DateTime dateTime;
  final bool isLoading;
  final String? errorMessage;
  final bool noteAdded;

  const AddNoteState({
    required this.title,
    required this.content,
    required this.dateTime,
    this.isLoading = false,
    this.errorMessage,
    this.noteAdded = false,
  });

  AddNoteState copyWith({
    String? title,
    String? content,
    DateTime? dateTime,
    bool? isLoading,
    String? errorMessage,
    bool? noteAdded,
  }) {
    return AddNoteState(
      title: title ?? this.title,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      noteAdded: noteAdded ?? this.noteAdded,
    );
  }
}
