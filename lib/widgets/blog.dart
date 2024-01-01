// blog.dart
import 'package:flutter/material.dart';

class Blog extends StatefulWidget {
  final String title;
  final String author;
  final String text;
  final String image;

  const Blog(
      {super.key,
      required this.image,
      required this.title,
      required this.author,
      required this.text});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  List<Widget> body = [];
  void processString(String inputString) {
    // print(inputString);
    for (int i = 0; i < inputString.length; i++) {
      if (inputString[i] == "<" && inputString[i + 1] != '/') {
        String start = inputString.substring(i + 1, i + 6);
        int j = i + 6;
        String temp = '';

        while (j < inputString.length) {
          if (inputString[j] != '<') {
            temp += inputString[j];
          } else {
            body.add(const SizedBox(height: 10));

            switch (start) {
              case "9876>":
                body.add(Text(
                  temp,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ));
                break;
              case "5432>":
                body.add(Text(
                  temp,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ));
                break;
              case "1010>":
                body.add(Text(
                  temp,
                  style: const TextStyle(
                      fontWeight: FontWeight.w100, fontSize: 10),
                ));
                break;
            }
            // body.add(const SizedBox(height: 10));
            break;
          }
          j++;
        }
        i = j; // Update the outer loop variable
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processString(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 240, 248),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 240, 248),
        foregroundColor: Color.fromARGB(255, 19, 33, 57),
        title: Text(
          widget.title,
          maxLines: 2,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            top: 20,
            right: MediaQuery.of(context).size.width * 0.05),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 4.0,
              ),
              child: Text(
                "Blog by",
                style: TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 19, 33, 57)),
              ),
            ),
            Row(children: [
              const Icon(Icons.account_circle,
                  color: Color.fromARGB(255, 19, 33, 57)),
              Text(
                widget.author,
                style: const TextStyle(color: Color.fromARGB(255, 19, 33, 57)),
              )
            ]),
            const SizedBox(height: 20),
            Image(image: NetworkImage(widget.image)),
            ...body,
          ],
        ),
      ),
    );
  }
}
