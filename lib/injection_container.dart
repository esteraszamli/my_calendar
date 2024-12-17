import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:my_calendar/data_source/holiday_remote_data_source.dart';
import 'package:my_calendar/data_source/notes_remote_data_source.dart';
import 'package:my_calendar/models/holiday_model.dart';
import 'package:my_calendar/models/note_model.dart';
import 'package:my_calendar/pages/add_note/cubit/add_note_cubit.dart';
import 'package:my_calendar/pages/calendar/cubit/calendar_cubit.dart';
import 'package:my_calendar/pages/edit_note/cubit/edit_note_cubit.dart';
import 'package:my_calendar/pages/note/cubit/note_cubit.dart';
import 'package:my_calendar/repository/holiday_repository.dart';
import 'package:my_calendar/repository/notes_repository.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Firebase
  getIt.registerFactory(() => FirebaseAuth.instance);
  getIt.registerFactory(() => FirebaseFirestore.instance);

  // Data source
  getIt.registerFactory(() => NotesRemoteDataSource(getIt()));
  getIt.registerFactory(() => HolidayRemoteDataSource(getIt()));

  // Rejestracja Dio
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    // Możesz tu dodać dodatkową konfigurację Dio, np.:
    dio.options.baseUrl = 'https://date.nager.at';
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
    return dio;
  });

  // Repository
  getIt.registerFactory(() => NotesRepository(getIt<NotesRemoteDataSource>()));
  getIt.registerFactory(() => HolidayRepository(getIt()));

  // Bloc
  getIt.registerFactoryParam<AddNoteCubit, DateTime, void>(
    (selectedDate, _) =>
        AddNoteCubit(getIt<NotesRepository>(), initialDate: selectedDate),
  );
  getIt.registerFactoryParam<EditNoteCubit, NoteModel, void>(
    (note, _) => EditNoteCubit(getIt<NotesRepository>(), note),
  );
  getIt.registerFactory(() =>
      CalendarCubit(getIt<NotesRepository>(), getIt<HolidayRepository>()));
  getIt.registerFactory(() => NoteCubit(getIt<NotesRepository>()));

  // Models
  getIt.registerFactory(() => NoteModel(
      id: '',
      title: '',
      content: '',
      dateTime: DateTime.now(),
      userID: '')); // Obsługę daty poprawić ?
  getIt.registerFactory(() => HolidayModel(
        localName: '',
        countryCode: '',
        date: '',
      ));
}
