import 'package:flutter/material.dart';
import 'package:se_project/widgets/postwidget.dart';
import 'auth.dart';
import 'classes/comment.dart';
import 'classes/post.dart';

class Home extends StatelessWidget {
  final double statusBarHeight;

  // Use the named parameter syntax for the constructor
  const Home({Key? key, required this.statusBarHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(statusBarHeight);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Container(
            padding: EdgeInsets.only(top: statusBarHeight),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Title"),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the new page when the button is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Auth()),
                    );
                  },
                  child: const Text('Signin/Signup'),
                ),
                const Text("Settings"),
              ],
            ),
          ),
        ),
      ),
      body: Column(children: [
        Container(
          color: Colors.deepPurple[200],
          child: Row(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    // addRepaintBoundaries: ,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      PostWidget(
                          post: Post(
                              title: "title",
                              author: "Author",
                              comments: [
                                Comment(
                                    author: "Author",
                                    authorid: "123",
                                    text: "comment text"),
                                Comment(
                                    author: "Author2",
                                    authorid: "1234",
                                    text: "comment text 2")
                              ],
                              text: "Post Text",
                              upvotes: 12)),
                      PostWidget(
                          post: Post(
                              title: "title",
                              author: "Author",
                              comments: [
                                Comment(
                                    author: "Author",
                                    authorid: "123",
                                    text: "comment text"),
                                Comment(
                                    author: "Author2",
                                    authorid: "1234",
                                    text: "comment text 2")
                              ],
                              text: "Post Text",
                              upvotes: 12)),
                      PostWidget(
                          post: Post(
                              title: "title",
                              author: "Author",
                              comments: [
                                Comment(
                                    author: "Author",
                                    authorid: "123",
                                    text: "comment text"),
                                Comment(
                                    author: "Author2",
                                    authorid: "1234",
                                    text: "comment text 2")
                              ],
                              text: "Post Text",
                              upvotes: 12)),
                      PostWidget(
                          post: Post(
                              title: "title",
                              author: "Author",
                              comments: [
                                Comment(
                                    author: "Author",
                                    authorid: "123",
                                    text: "comment text"),
                                Comment(
                                    author: "Author2",
                                    authorid: "1234",
                                    text: "comment text 2")
                              ],
                              text: "Post Text",
                              upvotes: 12)),
                      PostWidget(
                          post: Post(
                              title: "title",
                              author: "Author",
                              comments: [
                                Comment(
                                    author: "Author",
                                    authorid: "123",
                                    text: "comment text"),
                                Comment(
                                    author: "Author2",
                                    authorid: "1234",
                                    text: "comment text 2")
                              ],
                              text: "Post Text",
                              upvotes: 12)),
                      PostWidget(
                          post: Post(
                              title: "title",
                              author: "Author",
                              comments: [
                                Comment(
                                    author: "Author",
                                    authorid: "123",
                                    text: "comment text"),
                                Comment(
                                    author: "Author2",
                                    authorid: "1234",
                                    text: "comment text 2")
                              ],
                              text: "Post Text",
                              upvotes: 12)),
                      PostWidget(
                          post: Post(
                              title: "title",
                              author: "Author",
                              comments: [
                                Comment(
                                    author: "Author",
                                    authorid: "123",
                                    text: "comment text"),
                                Comment(
                                    author: "Author2",
                                    authorid: "1234",
                                    text: "comment text 2")
                              ],
                              text: "Post Text",
                              upvotes: 12))
                    ],
                  ))
            ],
          ),
        ),
        Container(
          color: Colors.cyan,
          height: MediaQuery.of(context).size.height * 0.1,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("button1"), Text("button2"), Text("button3")],
          ),
        )
      ]),
    );
  }
}
