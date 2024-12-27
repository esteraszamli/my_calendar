import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/pages/note/cubit/note_cubit.dart';
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
  late NoteCubit cubit;
  late MockNotesRepository mockRepository;

  setUp(() {
    mockRepository = MockNotesRepository();
    cubit = NoteCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('initial state', () {
    test('should have correct initial values', () {
      expect(cubit.state.note, isNull);
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.errorMessage, isNull);
      expect(cubit.state.noteDeleted, isFalse);
      expect(cubit.state.noteUpdated, isFalse);
    });
  });

  group('getNoteDetails', () {
    final testNote = NoteModel(
      id: 'test-id',
      title: 'Test Title',
      content: 'Test Content',
      dateTime: DateTime(2024, 1, 1),
      userID: 'user-123',
    );

    test('should fetch and emit note details successfully', () async {
      // Arrange
      when(() => mockRepository.getNoteById('test-id'))
          .thenAnswer((_) async => testNote);

      // Act
      await cubit.getNoteDetails('test-id');

      // Assert
      verify(() => mockRepository.getNoteById('test-id')).called(1);

      expect(cubit.state.note, equals(testNote));
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.errorMessage, isNull);
    });

    test('should set loading state while fetching note', () async {
      // Arrange
      when(() => mockRepository.getNoteById(any()))
          .thenAnswer((_) async => testNote);

      // Act
      cubit.getNoteDetails('test-id');

      // Assert - check loading state
      expect(cubit.state.isLoading, isTrue);
      expect(cubit.state.errorMessage, isNull);

      // Wait for completion
      await Future.delayed(Duration.zero);
    });

    test('should handle error when fetching note fails', () async {
      // Arrange
      when(() => mockRepository.getNoteById(any()))
          .thenThrow(Exception('Fetch error'));

      // Act
      await cubit.getNoteDetails('test-id');

      // Assert
      expect(cubit.state.note, isNull);
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.errorMessage, contains('Fetch error'));
    });
  });

  group('deleteNote', () {
    test('should delete note successfully', () async {
      // Arrange
      when(() => mockRepository.deleteNote('test-id'))
          .thenAnswer((_) async => {});

      // Act
      await cubit.deleteNote('test-id');

      // Assert
      verify(() => mockRepository.deleteNote('test-id')).called(1);

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.noteDeleted, isTrue);
      expect(cubit.state.errorMessage, isNull);
    });

    test('should set loading state while deleting note', () async {
      // Arrange
      when(() => mockRepository.deleteNote(any())).thenAnswer((_) async => {});

      // Act
      cubit.deleteNote('test-id');

      // Assert - check loading state
      expect(cubit.state.isLoading, isTrue);
      expect(cubit.state.errorMessage, isNull);

      // Wait for completion
      await Future.delayed(Duration.zero);
    });

    test('should handle error when deleting note fails', () async {
      // Arrange
      when(() => mockRepository.deleteNote(any()))
          .thenThrow(Exception('Delete error'));

      // Act
      await cubit.deleteNote('test-id');

      // Assert
      verify(() => mockRepository.deleteNote(any())).called(1);

      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.noteDeleted, isFalse);
      expect(cubit.state.errorMessage, contains('Delete error'));
      expect(
          cubit.state.errorMessage, contains('Błąd podczas usuwania notatki'));
    });
  });

  test('should maintain state between operations', () async {
    // Arrange
    final testNote = NoteModel(
      id: 'test-id',
      title: 'Test Title',
      content: 'Test Content',
      dateTime: DateTime(2024, 1, 1),
      userID: 'user-123',
    );

    when(() => mockRepository.getNoteById('test-id'))
        .thenAnswer((_) async => testNote);
    when(() => mockRepository.deleteNote('test-id'))
        .thenAnswer((_) async => {});

    // Act & Assert
    // First get note details
    await cubit.getNoteDetails('test-id');
    expect(cubit.state.note, equals(testNote));
    expect(cubit.state.noteDeleted, isFalse);

    // Then delete note
    await cubit.deleteNote('test-id');
    expect(cubit.state.note, equals(testNote)); // Note should still be in state
    expect(cubit.state.noteDeleted, isTrue);
  });
}
