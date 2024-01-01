import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/main.dart';

class PostLike extends StatefulWidget {
  final String postId;
  final int likesCount;
  const PostLike({super.key, required this.postId, required this.likesCount});

  @override
  State<PostLike> createState() => _PostLikeState();
}

class _PostLikeState extends State<PostLike> {
  late int likesCount;

  @override
  void initState() {
    super.initState();

    likesCount = widget.likesCount;
  }

  @override
  Widget build(BuildContext context) {
    var mylikes = Provider.of<LikesModel>(context);
    print(mylikes.myLikes);
    return Padding(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
        child: Row(children: [
          GestureDetector(
            onTap: () {
              if (!mylikes.myLikes.contains(widget.postId)) {
                likesCount += 1;
                mylikes.remLike(widget.postId);
                Provider.of<ItemsModel>(context, listen: false)
                    .addLike(widget.postId);
              } else {
                likesCount -= 1;
                mylikes.addLike(widget.postId);
                Provider.of<ItemsModel>(context, listen: false)
                    .removeLike(widget.postId);
              }
            },
            child: mylikes.myLikes.contains(widget.postId)
                ? const Icon(Icons.thumb_up, size: 12, color: Colors.blue)
                : const Icon(
                    Icons.thumb_up_alt_outlined,
                    size: 12,
                    color: Color.fromARGB(255, 219, 219, 219),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SizedBox(
              width: 5,
              child: Text(
                "$likesCount",
                style: const TextStyle(fontSize: 10),
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
        ]));
  }
}
