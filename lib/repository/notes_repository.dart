import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_calendar/data_source/notes_remote_data_source.dart';
import 'package:my_calendar/models/note_model.dart';

class NotesRepository {
  NotesRepository(this._noteDataSource);

  final NotesRemoteDataSource _noteDataSource;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<NoteModel> _createNoteModel(List<Map<String, dynamic>> notesData) {
    return notesData.map((noteData) {
      // ??
      return NoteModel(
        id: noteData['id'],
        title: noteData['title'] ?? '',
        content: noteData['content'] ?? '',
        dateTime:
            (noteData['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
        userID: noteData['userID'] ?? '',
      );
    }).toList();
  }

  Stream<List<NoteModel>> getNotesStream() {
    return _noteDataSource.getNotesStream().map((notes) {
      return _createNoteModel(notes);
    });
  }

  Future<NoteModel?> getNoteById(String id) async {
    try {
      final noteData = await _noteDataSource.getNoteById(id);
      if (noteData != null) {
        return NoteModel.fromMap(noteData);
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addNote(NoteModel note) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('Użytkownik jest niezalogowany');
    }
    final noteData = {
      'title': note.title,
      'content': note.content,
      'dateTime': Timestamp.fromDate(note.dateTime),
      'userID': currentUser.uid,
    };
    await _noteDataSource.addNote(noteData, currentUser.uid);
  }

  Future<void> deleteNote(String noteID) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('Użytkownik jest niezalogowany');
    }
    // Pobranie dokumentu przed usunięciem
    final noteDoc = await _noteDataSource.getNoteById(noteID);
    if (noteDoc == null) {
      throw Exception('Nie znaleziono notatki');
    }
    await _noteDataSource.deleteNote(noteID);
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      await _noteDataSource.updateNote(note);
    } catch (error) {
      throw Exception('Błąd podczas aktualizacji notatki: $error');
    }
  }
}
