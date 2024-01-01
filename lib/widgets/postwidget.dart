import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/comment.dart';
import 'blog.dart';

class PostWidget extends StatelessWidget {
  final String postId;
  final String title;
  final String author;
  final String text;
  final bool like;
  final String description;
  final String image;
  final String avatar;
  // final List<String> tags;
  final String id;
  final List<dynamic> likes;
  final List<Comment> comments;

  PostWidget({
    super.key,
    required this.avatar,
    required this.like,
    required this.postId,
    required this.image,
    required this.title,
    required this.description,
    required this.author,
    required this.comments,
    required this.id,
    required this.likes,
    required this.text,
  });

  //   void setLike() async {
  @override
  Widget build(BuildContext context) {
    var likemodel = Provider.of<LikesModel>(context);
    var itemmodel = Provider.of<ItemsModel>(context);
    // print("Rebuild");
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
            bottom: BorderSide(color: Color.fromARGB(255, 186, 201, 217)),
            // top: BorderSide(color: Colors.white12)
          )),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 65,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black, width: 2.0),
                  // ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                //   child: Icon(
                //     Icons.image,
                //     color: Color.fromARGB(255, 219, 219, 219),
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
                                        color: Color.fromARGB(255, 31, 31, 31),
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
                                            color: Color.fromARGB(
                                                255, 31, 31, 31))))
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
                                  avatar == ''
                                      ? const Icon(
                                          Icons.account_circle_sharp,
                                          size: 12,
                                          weight: 1,
                                          color:
                                              Color.fromARGB(255, 31, 31, 31),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(avatar),
                                          radius: 6),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(author,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 8,
                                        color: Color.fromARGB(255, 31, 31, 31),
                                      )),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.2),
                                  child: Row(children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (likemodel.myLikes
                                            .contains(postId)) {
                                          likemodel.remLike(postId);
                                          itemmodel.removeLike(postId, id);
                                        } else {
                                          likemodel.addLike(postId);
                                          itemmodel.addLike(postId, id);
                                        }
                                      },
                                      child: likemodel.myLikes.contains(postId)
                                          ? const Icon(Icons.thumb_up,
                                              size: 12, color: Colors.blue)
                                          : const Icon(
                                              Icons.thumb_up_alt_outlined,
                                              size: 12,
                                              color: Color.fromARGB(
                                                  255, 31, 31, 31),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: SizedBox(
                                        width: 5,
                                        child: Text(
                                          "${itemmodel.items.firstWhere((element) => element["id"] == postId)["likes"].length}",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Color.fromARGB(
                                                  255, 31, 31, 31)),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    // false
                                    //     ? const Icon(
                                    //         Icons.delete,
                                    //         size: 12,
                                    //         color: Color.fromARGB(255, 219, 219, 219),
                                    //       )
                                    //     : const SizedBox.shrink()
                                  ]))
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
