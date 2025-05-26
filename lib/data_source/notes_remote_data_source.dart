import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_calendar/core/error/error_handler.dart';
import 'package:my_calendar/models/note_model.dart';

class NotesRemoteDataSource {
  NotesRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getNotesStream() {
    String? userID = _auth.currentUser?.uid;
    if (userID != null) {
      return _firestore
          .collection('notes')
          .where('userID', isEqualTo: userID)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => {...doc.data(), 'id': doc.id})
            .toList();
      });
    }
    return Stream.value([]);
  }

  Future<Map<String, dynamic>?> getNoteById(String id) async {
    try {
      String? userID = _auth.currentUser?.uid;

      if (userID != null) {
        final doc = await _firestore.collection('notes').doc(id).get();

        if (doc.exists && doc.data()?['userID'] == userID) {
          return {...doc.data() as Map<String, dynamic>, 'id': doc.id};
        }
      }
      return null;
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }

  Future<void> addNote(Map<String, dynamic> noteData, String userID) async {
    try {
      await _firestore.collection('notes').add({
        ...noteData,
        'userID': userID,
      });
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }

  Future<void> deleteNote(String noteID) async {
    try {
      await _firestore.collection('notes').doc(noteID).delete();
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }

  Future<void> updateNote(NoteModel note) async {
    final json = note.toMap();
    json.remove('id');
    try {
      await _firestore.collection('notes').doc(note.id).update(json);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }
}
