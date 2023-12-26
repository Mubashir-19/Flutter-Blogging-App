import 'package:flutter/material.dart';
import 'package:se_project/widgets/PostLike.dart';

import '../classes/comment.dart';
import 'blog.dart';

class PostWidget extends StatelessWidget {
  final String postId;
  final String title;
  final String author;
  final String text;
  final String description;
  final String image;
  // final List<String> tags;
  final String id;
  final DateTime date = DateTime.now();
  final int upvotes;
  final List<Comment> comments;

  PostWidget({
    super.key,
    required this.postId,
    required this.image,
    required this.title,
    required this.description,
    required this.author,
    required this.comments,
    required this.id,
    this.upvotes = 0,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Blog(
              image: image,
              title: title,
              author: author,
              text: text,
            ),
          ),
        )
      },
      child: Container(
          // margin: const EdgeInsets.only(top: 10, bottom: 10),
          height: 80,
          padding: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.white12),
            // top: BorderSide(color: Colors.white12)
          )),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 60,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black, width: 2.0),
                  // ),
                  child: Image(
                    image: NetworkImage(image),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
                //   child: Icon(
                //     Icons.image,
                //     color: Colors.white70,
                //     size: 50,
                //   ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(
                                    title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Text(description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 7,
                                            color: Colors.white70)))
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.account_circle_sharp,
                                    size: 12,
                                    weight: 1,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(author,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 8,
                                        color: Colors.white70,
                                      )),
                                ],
                              ),
                              PostLike(id: postId),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
