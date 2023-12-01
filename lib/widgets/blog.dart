// blog.dart

import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  final String title;
  final String author;
  final String text;

  Blog({required this.title, required this.author, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.102),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
        foregroundColor: Colors.white70,
        title: Text(
          title,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 4.0,
              ),
              child: Text(
                "Blog by",
                style: TextStyle(fontSize: 10, color: Colors.white70),
              ),
            ),
            Row(children: [
              const Icon(Icons.account_circle, color: Colors.white70),
              Text(
                author,
                style: const TextStyle(color: Colors.white70),
              )
            ]),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                text,
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
