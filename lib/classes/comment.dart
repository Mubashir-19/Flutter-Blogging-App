class Comment {
  final String text;
  String author;
  String authorid;
  DateTime timestamp;

  Comment({required this.text, required this.author, required this.authorid})
      : timestamp = DateTime.now();

  void displayCommentDetails() {
    print('Author: $author');
    print('Timestamp: $timestamp');
    print('Comment: $text');
  }
}
