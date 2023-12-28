import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/main.dart';
import 'package:se_project/widgets/postwidget.dart';
import 'package:se_project/widgets/tagbar.dart';

import '../classes/comment.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

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

    // print(widget.items);
    if (tag == "for you") {
      temp = _tagItems;

      // print(temp);
    } else {
      for (var item in _tagItems) {
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
              bottom: 30, top: MediaQuery.of(context).size.height * 0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: const Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //       right: MediaQuery.of(context).size.width * 0.05),
              //   child: const Icon(
              //     Icons.notifications,
              //     color: Colors.white70,
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10))),
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