import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:my_calendar/data_source/notes_remote_data_source.dart';
import 'package:my_calendar/model/note_model.dart';
import 'package:my_calendar/pages/add_note/cubit/add_note_cubit.dart';
import 'package:my_calendar/pages/calendar/cubit/calendar_cubit.dart';
import 'package:my_calendar/pages/edit_note/cubit/edit_note_cubit.dart';
import 'package:my_calendar/pages/note/cubit/note_cubit.dart';
import 'package:my_calendar/repository/notes_repository.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Firebase
  getIt.registerFactory(() => FirebaseAuth.instance);
  getIt.registerFactory(() => FirebaseFirestore.instance);

  // Data source
  getIt.registerFactory(() => NotesRemoteDataSource(getIt()));

  // Repository
  getIt.registerFactory(() => NotesRepository(getIt<NotesRemoteDataSource>()));

  // Bloc
  getIt.registerFactory(() =>
      AddNoteCubit(getIt<NotesRepository>(), initialDate: DateTime.now()));
  getIt.registerFactory(
      () => EditNoteCubit(getIt<NotesRepository>(), getIt<NoteModel>()));
  getIt.registerFactory(() => CalendarCubit(getIt<NotesRepository>()));
  getIt.registerFactory(() => NoteCubit(getIt<NotesRepository>()));

  // Model
  getIt.registerFactory(() => NoteModel(
      id: '', title: '', content: '', dateTime: DateTime.now(), userID: ''));
}
