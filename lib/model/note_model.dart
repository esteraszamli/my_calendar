class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime dateTime;
  final String userID;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.dateTime,
    required this.userID,
  });
}
