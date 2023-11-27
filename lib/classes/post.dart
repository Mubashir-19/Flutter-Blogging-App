import 'dart:core';

import 'comment.dart';

class Post {
  // Properties
  late String id;
  late String authorid;
  String title;
  String author;
  int upvotes;
  DateTime timestamp;
  List<Comment> comments;
  String text;

  // Constructor
  Post(
      {required this.title,
      required this.text,
      required this.author,
      required this.upvotes,
      required this.comments})
      : timestamp = DateTime.now() {
    // Generate a unique ID (for simplicity, you might want to use a library like uuid)
    id = '${timestamp.millisecondsSinceEpoch}_${title.hashCode}';
  }

  // Method to display post details
  void displayPostDetails() {
    print('ID: $id');
    print('Title: $title');
    print('Author: $author');
    print('Upvotes: $upvotes');
    print('Timestamp: $timestamp');
    print('Comments: ${comments.length} comments');
  }

  // Method to add a comment to the post
  void addComment(String text, String author, String id) {
    Comment newComment = Comment(author: author, text: text, authorid: id);
    comments.add(newComment);
    print('Comment added by $author: $text');
  }
}
