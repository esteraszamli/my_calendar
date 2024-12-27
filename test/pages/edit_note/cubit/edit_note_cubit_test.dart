import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/pages/edit_note/cubit/edit_note_cubit.dart';
import 'package:my_calendar/repository/notes_repository.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(NoteModel(
        id: 'test-id',
        title: 'test',
        content: 'test',
        dateTime: DateTime.now(),
        userID: 'test-user'));
  });
  late EditNoteCubit cubit;
  late MockNotesRepository mockRepository;
  late NoteModel initialNote;

  setUp(() {
    mockRepository = MockNotesRepository();
    initialNote = NoteModel(
      id: 'test-id',
      title: 'Initial Title',
      content: 'Initial Content',
      dateTime: DateTime(2024, 1, 1),
      userID: 'user-123',
    );
    cubit = EditNoteCubit(mockRepository, initialNote);
  });

  tearDown(() {
    cubit.close();
  });

  group('initialization', () {
    test('should initialize state from note correctly', () {
      expect(cubit.state.id, equals(initialNote.id));
      expect(cubit.state.title, equals(initialNote.title));
      expect(cubit.state.content, equals(initialNote.content));
      expect(cubit.state.dateTime, equals(initialNote.dateTime));
      expect(cubit.state.userID, equals(initialNote.userID));
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.errorMessage, isNull);
      expect(cubit.state.noteUpdated, isFalse);
    });

    test('EditNoteState.fromNote factory should create correct state', () {
      final state = EditNoteState.fromNote(initialNote);

      expect(state.id, equals(initialNote.id));
      expect(state.title, equals(initialNote.title));
      expect(state.content, equals(initialNote.content));
      expect(state.dateTime, equals(initialNote.dateTime));
      expect(state.userID, equals(initialNote.userID));
      expect(state.isLoading, isFalse);
      expect(state.errorMessage, isNull);
      expect(state.noteUpdated, isFalse);
    });
  });

  group('updateField', () {
    test('should update title correctly', () {
      const newTitle = 'New Test Title';
      cubit.updateField('title', newTitle);

      expect(cubit.state.title, equals(newTitle));
      expect(cubit.state.content, equals(initialNote.content));
    });

    test('should update content correctly', () {
      const newContent = 'New Test Content';
      cubit.updateField('content', newContent);

      expect(cubit.state.content, equals(newContent));
      expect(cubit.state.title, equals(initialNote.title));
    });

    test('should not update other fields when unknown field provided', () {
      cubit.updateField('unknown', 'Test Value');

      expect(cubit.state.title, equals(initialNote.title));
      expect(cubit.state.content, equals(initialNote.content));
    });
  });

  group('updateNote', () {
    test('should show error when title is empty', () async {
      cubit.updateField('title', '');
      await cubit.updateNote();

      expect(cubit.state.errorMessage, equals('Uzupełnij wymagane pola'));
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.noteUpdated, isFalse);
      verifyNever(() => mockRepository.updateNote(any()));
    });

    test('should show error when content is empty', () async {
      cubit.updateField('content', '');
      await cubit.updateNote();

      expect(cubit.state.errorMessage, equals('Uzupełnij wymagane pola'));
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.noteUpdated, isFalse);
      verifyNever(() => mockRepository.updateNote(any()));
    });

    test('should update note successfully', () async {
      // Arrange
      const newTitle = 'Updated Title';
      const newContent = 'Updated Content';
      cubit.updateField('title', newTitle);
      cubit.updateField('content', newContent);

      when(() => mockRepository.updateNote(any()))
          .thenAnswer((_) => Future.value());

      // Act
      await cubit.updateNote();

      // Assert
      verify(() => mockRepository.updateNote(any(
          that: predicate<NoteModel>((note) =>
              note.id == initialNote.id &&
              note.title == newTitle.trim() &&
              note.content == newContent.trim() &&
              note.dateTime == initialNote.dateTime &&
              note.userID == initialNote.userID)))).called(1);

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.noteUpdated, isTrue);
      expect(cubit.state.errorMessage, isNull);
    });

    test('should handle error when updating note fails', () async {
      // Arrange
      when(() => mockRepository.updateNote(any()))
          .thenThrow(Exception('Update error'));

      // Act
      await cubit.updateNote();

      // Assert
      verify(() => mockRepository.updateNote(any())).called(1);
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.noteUpdated, isFalse);
      expect(cubit.state.errorMessage, contains('Update error'));
    });

    test('should trim fields before updating', () async {
      // Arrange
      cubit.updateField('title', '  Spaced Title  ');
      cubit.updateField('content', '  Spaced Content  ');
      when(() => mockRepository.updateNote(any()))
          .thenAnswer((_) => Future.value());

      // Act
      await cubit.updateNote();

      // Assert
      verify(() => mockRepository.updateNote(any(
          that: predicate<NoteModel>((note) =>
              note.title == 'Spaced Title' &&
              note.content == 'Spaced Content')))).called(1);
    });
  });
}
