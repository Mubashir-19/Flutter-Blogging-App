import 'package:flutter/material.dart';

class PostLike extends StatefulWidget {
  final String id;
  final String authorid;
  final bool like;
  final int likesCount;
  final Function updateLike;
  const PostLike(
      {super.key,
      required this.updateLike,
      required this.likesCount,
      required this.id,
      required this.like,
      required this.authorid});

  @override
  State<PostLike> createState() => _PostLikeState();
}

class _PostLikeState extends State<PostLike> {
  late bool like;
  late int likesCount;
  List<String> myLikes = [];

  @override
  void initState() {
    super.initState();
    like = widget.like;
    likesCount = widget.likesCount;
  }

  void setLike() async {
    // myLikes
    setState(() {
      like = !like;
    });

    await widget.updateLike(like);

    // print(myLikes);
  }

  @override
  Widget build(BuildContext context) {
    // print(myLikes);
    return Padding(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
        child: Row(children: [
          GestureDetector(
            onTap: setLike,
            child: like
                ? const Icon(Icons.thumb_up, size: 12, color: Colors.blue)
                : const Icon(
                    Icons.thumb_up_alt_outlined,
                    size: 12,
                    color: Colors.white70,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SizedBox(
              width: 5,
              child: Text(
                "${like ? likesCount : likesCount - 1}",
                style: const TextStyle(fontSize: 10),
                maxLines: 1,
              ),
            ),
          ),
          // false
          //     ? const Icon(
          //         Icons.delete,
          //         size: 12,
          //         color: Colors.white70,
          //       )
          //     : const SizedBox.shrink()
        ]));
  }
}
