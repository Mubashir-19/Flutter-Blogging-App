import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostLike extends StatefulWidget {
  final String id;
  const PostLike({super.key, required this.id});

  @override
  State<PostLike> createState() => _PostLikeState();
}

class _PostLikeState extends State<PostLike> {
  bool like = false;
  List<String> myLikes = [];

  @override
  void initState() {
    super.initState();
    loadListFromSharedPreferences();
  }

  Future<void> loadListFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      print(prefs.getStringList('likes'));
      if (prefs.getStringList('likes') == null) {
        prefs.setStringList('likes', []);
      } else {
        myLikes = prefs.getStringList('likes')!;
      }
    });
  }

  void setLike() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      myLikes.add(widget.id);
      prefs.setStringList('likes', myLikes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
        child: Row(children: [
          GestureDetector(
            onTap: setLike,
            child: myLikes.contains(widget.id)
                ? const Icon(
                    Icons.thumb_up_alt_outlined,
                    size: 12,
                    color: Colors.white70,
                  )
                : const Icon(Icons.thumb_up, size: 12, color: Colors.blue),
          ),
          const SizedBox(
            width: 5,
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
