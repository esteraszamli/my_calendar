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

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      dateTime: map['dateTime']?.toDate() ?? DateTime.now(),
      userID: map['userID'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateTime': dateTime,
      'userID': userID,
    };
  }
}
