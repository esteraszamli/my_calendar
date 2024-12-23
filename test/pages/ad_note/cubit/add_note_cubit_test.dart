import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/pages/add_note/cubit/add_note_cubit.dart';
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

  late AddNoteCubit cubit;
  late MockNotesRepository mockRepository;
  late DateTime initialDate;

  setUp(() {
    mockRepository = MockNotesRepository();
    initialDate = DateTime(2024, 1, 1);
    cubit = AddNoteCubit(mockRepository, initialDate: initialDate);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be correct', () {
    expect(cubit.state.title, '');
    expect(cubit.state.content, '');
    expect(cubit.state.dateTime, initialDate);
    expect(cubit.state.isLoading, false);
    expect(cubit.state.errorMessage, null);
    expect(cubit.state.noteAdded, false);
  });

  group('updateField', () {
    test('should update title correctly', () {
      cubit.updateField('title', 'Test Title');

      expect(cubit.state.title, 'Test Title');
      expect(cubit.state.content, '');
    });

    test('should update content correctly', () {
      cubit.updateField('content', 'Test Content');

      expect(cubit.state.content, 'Test Content');
      expect(cubit.state.title, '');
    });

    test('should not update other fields when unknown field provided', () {
      cubit.updateField('unknown', 'Test');

      expect(cubit.state.title, '');
      expect(cubit.state.content, '');
    });
  });

  group('addNote', () {
    test('should show error when fields are empty', () async {
      await cubit.addNote();

      expect(cubit.state.errorMessage, 'Uzupełnij wymagane pola');
      expect(cubit.state.isLoading, false);
      expect(cubit.state.noteAdded, false);
      verifyNever(() => mockRepository.addNote(any()));
    });

    test('should add note successfully', () async {
      // Arrange
      cubit.updateField('title', 'Test Title');
      cubit.updateField('content', 'Test Content');
      when(() => mockRepository.addNote(any()))
          .thenAnswer((_) => Future.value());

      // Act
      await cubit.addNote();

      // Assert
      verify(() => mockRepository.addNote(any())).called(1);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.noteAdded, true);
      expect(cubit.state.errorMessage, null);
    });

    test('should handle error when adding note fails', () async {
      // Arrange
      cubit.updateField('title', 'Test Title');
      cubit.updateField('content', 'Test Content');
      when(() => mockRepository.addNote(any()))
          .thenThrow(Exception('Test error'));

      // Act
      await cubit.addNote();

      // Assert
      verify(() => mockRepository.addNote(any())).called(1);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.noteAdded, false);
      expect(cubit.state.errorMessage, contains('Test error'));
    });

    test('should trim title and content before saving', () async {
      // Arrange
      cubit.updateField('title', '  Test Title  ');
      cubit.updateField('content', '  Test Content  ');
      when(() => mockRepository.addNote(any()))
          .thenAnswer((_) => Future.value());

      // Act
      await cubit.addNote();

      // Assert
      verify(() => mockRepository.addNote(any(
          that: predicate<NoteModel>((note) =>
              note.title == 'Test Title' &&
              note.content == 'Test Content')))).called(1);
    });
  });
}
