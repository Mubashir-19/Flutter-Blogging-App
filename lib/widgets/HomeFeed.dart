import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/main.dart';
import 'package:se_project/widgets/postwidget.dart';
import 'package:se_project/widgets/tagbar.dart';

import '../classes/comment.dart';

class HomeFeed extends StatefulWidget {
  final String avatar;
  final String authorid;
  const HomeFeed({super.key, required this.avatar, required this.authorid});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  // var items = [];
  late var _tagItems = [];
  @override
  void initState() {
    super.initState();
    // Your function call goes here
    _tagItems = Provider.of<ItemsModel>(context, listen: false).items;
  }

  void selectedTab(String tag) {
    var temp = [];
    var allItems = Provider.of<ItemsModel>(context, listen: false).items;
    // print(widget.items);
    if (tag == "for you") {
      temp = allItems;

      // print(temp);
    } else {
      for (var item in allItems) {
        if (item["title"].toLowerCase().contains(tag) ||
            item["author"].toLowerCase().contains(tag) ||
            item["text"].toLowerCase().contains(tag) ||
            item["description"].toLowerCase().contains(tag)) {
          temp.add(item);
        }
      }
      // print(keyword);
    }

    setState(() {
      _tagItems = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(Provider.of<LikesModel>(context).myLikes);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: 20, top: MediaQuery.of(context).size.height * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: MediaQuery.of(context).size.width * 0.05),
              //   child: Image.asset(
              //     'images/logo.png',
              //     height: 50,
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: const Text(
                  "Home",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: Color.fromARGB(255, 128, 148, 171)))),
          height: 30,
          width: MediaQuery.of(context).size.width,
          child: MyTabBar(selectedTab: selectedTab),
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: _tagItems.length,
          itemBuilder: (context, index) {
            return PostWidget(
              like: Provider.of<LikesModel>(context)
                  .myLikes
                  .contains(_tagItems[index]["id"]),
              postId: _tagItems[index]["id"],
              image: _tagItems[index]["img"],
              description: _tagItems[index]["description"],
              // key: Key(_tagItems[index]["id"]),
              id: _tagItems[index]["authorid"],
              title: _tagItems[index]["title"],
              likes: _tagItems[index]["likes"],
              author: _tagItems[index]["author"],
              avatar: _tagItems[index]["authorid"] == widget.authorid
                  ? widget.avatar
                  : _tagItems[index]["avatar"],
              comments: [
                Comment(author: "Mubashir", authorid: "1", text: "Some text")
              ],
              text: _tagItems[index]["text"],
            );
          },
        )),
      ],
    );
  }
}


// ListView(
//           // addRepaintBoundaries: ,
//           padding: EdgeInsets.zero,
//           scrollDirection: Axis.vertical,

//           children: [
//             for (var item in items)
//               PostWidget(
//                 description: "description",
//                 key: Key(item["id"]),
//                 id: item["id"],
//                 title: "title",
//                 upvotes: 2,
//                 author: "Author",
//                 comments: [
//                   Comment(author: "Mubashir", authorid: "1", text: "Some text")
//                 ],
//                 text: "text",
//               ),
//           ],
//         )