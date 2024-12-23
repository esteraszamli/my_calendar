import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_calendar/models/holiday_model.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/pages/calendar/cubit/calendar_cubit.dart';
import 'package:my_calendar/repository/holiday_repository.dart';
import 'package:my_calendar/repository/notes_repository.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

class MockHolidayRepository extends Mock implements HolidayRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(NoteModel(
        id: 'test-id',
        title: 'test',
        content: 'test',
        dateTime: DateTime.now(),
        userID: 'test-user'));

    registerFallbackValue(
        HolidayModel(localName: 'test', date: '2024-01-01', countryCode: 'PL'));
  });

  late CalendarCubit cubit;
  late MockNotesRepository mockNotesRepository;
  late MockHolidayRepository mockHolidayRepository;

  setUp(() {
    mockNotesRepository = MockNotesRepository();
    mockHolidayRepository = MockHolidayRepository();
    cubit = CalendarCubit(mockNotesRepository, mockHolidayRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('initial state', () {
    test('should have correct initial values', () {
      expect(cubit.state.notes, isEmpty);
      expect(cubit.state.holidays, isEmpty);
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.errorMessage, isEmpty);
    });
  });

  group('start', () {
    final testDate = DateTime(2024, 1, 15);
    final testHolidays = [
      HolidayModel(
          localName: 'New Year', date: '2024-01-01', countryCode: 'PL'),
      HolidayModel(
          localName: 'Christmas', date: '2024-12-25', countryCode: 'PL'),
    ];
    final testNotes = [
      NoteModel(
        id: '1',
        title: 'Note 1',
        content: 'Content 1',
        dateTime: DateTime(2024, 1, 15),
        userID: 'user1',
      ),
      NoteModel(
        id: '2',
        title: 'Note 2',
        content: 'Content 2',
        dateTime: DateTime(2024, 1, 16),
        userID: 'user1',
      ),
    ];

    test('should load holidays and notes for specific date', () async {
      // Arrange
      when(() => mockHolidayRepository.getHolidays(2024))
          .thenAnswer((_) async => testHolidays);
      when(() => mockNotesRepository.getNotesStream())
          .thenAnswer((_) => Stream.value(testNotes));

      // Act
      await cubit.start(testDate);
      await Future.delayed(
          const Duration(milliseconds: 100)); // Wait for state update

      // Assert
      verify(() => mockHolidayRepository.getHolidays(2024)).called(1);
      verify(() => mockNotesRepository.getNotesStream()).called(1);

      expect(cubit.state.holidays, equals(testHolidays));
      expect(
          cubit.state.notes, equals([testNotes[0]]) // Only note from January 15
          );
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.errorMessage, isEmpty);
    });

    test('should load all notes when no date is specified', () async {
      // Arrange
      when(() => mockHolidayRepository.getHolidays(any()))
          .thenAnswer((_) async => testHolidays);
      when(() => mockNotesRepository.getNotesStream())
          .thenAnswer((_) => Stream.value(testNotes));

      // Act
      await cubit.start();
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(cubit.state.notes, equals(testNotes));
      expect(cubit.state.isLoading, isFalse);
    });

    test('should handle holiday repository error', () async {
      // Arrange
      when(() => mockHolidayRepository.getHolidays(any()))
          .thenThrow(Exception('Holiday fetch error'));
      when(() => mockNotesRepository.getNotesStream())
          .thenAnswer((_) => Stream.value([]));

      // Act
      await cubit.start();

      // Assert
      expect(cubit.state.errorMessage, contains('Holiday fetch error'));
      expect(cubit.state.isLoading, isFalse);
    });

    test('should handle notes stream error', () async {
      // Arrange
      when(() => mockHolidayRepository.getHolidays(any()))
          .thenAnswer((_) async => []);
      when(() => mockNotesRepository.getNotesStream())
          .thenAnswer((_) => Stream.error(Exception('Notes stream error')));

      // Act
      await cubit.start();

      // Wait for stream error to be processed
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(cubit.state.errorMessage, contains('Notes stream error'));
    });

    test(
        'should cancel previous subscription when start is called multiple times',
        () async {
      // Arrange
      final controller = StreamController<List<NoteModel>>();
      when(() => mockHolidayRepository.getHolidays(any()))
          .thenAnswer((_) async => []);
      when(() => mockNotesRepository.getNotesStream())
          .thenAnswer((_) => controller.stream);

      // Act
      await cubit.start();
      await cubit.start(); // Should cancel previous subscription

      // Clean up
      await controller.close();

      // Assert
      verify(() => mockNotesRepository.getNotesStream()).called(2);
    });
  });

  test('should clean up stream subscription on close', () async {
    // Arrange
    final controller = StreamController<List<NoteModel>>();
    when(() => mockHolidayRepository.getHolidays(any()))
        .thenAnswer((_) async => []);
    when(() => mockNotesRepository.getNotesStream())
        .thenAnswer((_) => controller.stream);

    // Act
    await cubit.start();
    await cubit.close();

    // Clean up
    await controller.close();
  });
}
