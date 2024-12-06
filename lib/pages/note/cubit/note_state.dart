part of 'note_cubit.dart';

class NoteState {
  const NoteState({
    this.note,
    this.isLoading = false,
    this.errorMessage,
    this.noteDeleted = false,
    this.noteUpdated = false,
  });

  final NoteModel? note;
  final bool isLoading;
  final String? errorMessage;
  final bool noteDeleted;
  final bool noteUpdated;

  NoteState copyWith({
    NoteModel? note,
    bool? isLoading,
    String? errorMessage,
    bool? noteDeleted,
    bool? noteUpdated,
  }) {
    return NoteState(
      note: note ?? this.note,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      noteDeleted: noteDeleted ?? this.noteDeleted,
      noteUpdated: noteUpdated ?? this.noteUpdated,
    );
  }
}
