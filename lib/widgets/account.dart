import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/main.dart';
import 'package:se_project/widgets/postwidget.dart';

class Account extends StatefulWidget {
  final String email;
  final String username;
  final String authorid;
  const Account(
      {super.key,
      required this.authorid,
      required this.username,
      required this.email});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<String> myLikes = [];
  dynamic items;
  @override
  void initState() {
    super.initState();
    // Your function call goes here
    myLikes = Provider.of<LikesModel>(context, listen: false).myLikes;
    items = Provider.of<ItemsModel>(context, listen: false)
        .items
        .where((element) => element["authorid"] == widget.authorid);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ListView(children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: 30, top: MediaQuery.of(context).size.height * 0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white70,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.username,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Text(
          "About me",
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text("lorem ipsum.....................",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.bold)),
        ...[
          for (var item in items)
            PostWidget(
              like: myLikes.contains(item["id"]),
              postId: item["id"],
              image: item["img"],
              description: item["description"],
              // key: Key(item["id"]),
              id: item["authorid"],
              title: item["title"],
              likes: item["likes"],
              author: item["author"],
              comments: [],
              text: item["text"],
            )
        ]
      ]),
    );
  }
}
