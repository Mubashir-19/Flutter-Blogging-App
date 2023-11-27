import 'package:flutter/material.dart';

import '../classes/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        color: Colors.blue[400],
        height: 100,
        child: Column(
          children: [Text(post.title), Text(post.text)],
        ));
  }
}
