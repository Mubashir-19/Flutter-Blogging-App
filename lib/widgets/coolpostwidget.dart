import 'package:flutter/material.dart';

import '../classes/comment.dart';

class PostWidget extends StatefulWidget {
  final String title;
  final String author;
  DateTime dateOfLastUpdate = DateTime.now();
  int upvotes;
  List<Comment> comments;

  PostWidget({
    required this.title,
    required this.author,
    required this.comments,
    this.upvotes = 0,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  void _incrementUpvotes() {
    setState(() {
      widget.upvotes++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Posted by u/${widget.author} • ${widget.dateOfLastUpdate}',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_upward, color: Colors.orange),
                    onPressed: _incrementUpvotes,
                  ),
                  SizedBox(width: 4.0),
                  Text('${widget.upvotes}'),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.comment, color: Colors.blue),
                    onPressed: () => {},
                  ),
                  SizedBox(width: 4.0),
                  Text('${widget.comments}'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
