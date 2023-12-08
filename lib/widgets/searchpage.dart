import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:se_project/widgets/postwidget.dart';
import 'package:se_project/widgets/tagbar.dart';

import '../classes/comment.dart';

class SearchPage extends StatefulWidget {
  final dynamic items;
  const SearchPage({required this.items, super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchedItems = [];
  // var widget.items = [];
  TextEditingController searchtext = TextEditingController(text: '');
  // @override
  // void initState() {
  //   super.initState();
  //   // Your function call goes here
  //   getjson();
  // }

  // Future<void> getjson() async {
  //   // final String response =
  //   //     await rootBundle.loadString("lib/temp/blogdata.json");
  //   // final data = await json.decode(response);
  //   var response =
  //       await http.get(Uri.parse("http://192.168.100.9:4000/getall"));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       widget.items = json.decode(response.body);
  //       ;

  //       // for (var item in widget.items) print(item["id"]);
  //     });
  //   }
  // }

  void searchPosts(String keyword) {
    keyword = keyword.toLowerCase();
    var temp = [];

    for (var item in widget.items) {
      if (item["title"].toLowerCase().contains(keyword) ||
          item["author"].toLowerCase().contains(keyword) ||
          item["text"].toLowerCase().contains(keyword) ||
          item["description"].toLowerCase().contains(keyword)) {
        temp.add(item);
      }
    }
    // print(keyword);
    setState(() {
      searchedItems = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(
                bottom: 15, top: MediaQuery.of(context).size.height * 0.07),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: const Text(
                      "Explore",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ])),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                  cursorHeight: 13,
                  controller: searchtext,
                  onChanged: (string) {
                    searchPosts(string);
                  },
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white70,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(31, 255, 255, 255),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(76, 255, 255, 255),
                            style: BorderStyle.solid,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(5)))))),
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: searchedItems.length,
          itemBuilder: (context, index) {
            return PostWidget(
              description: searchedItems[index]["description"],
              image: searchedItems[index]["img"],
              // key: Key(searchedItems[index]["id"]),
              id: searchedItems[index]["authorid"],
              title: searchedItems[index]["title"],
              upvotes: searchedItems[index]["upvotes"],
              author: searchedItems[index]["author"],
              comments: [
                Comment(author: "Mubashir", authorid: "1", text: "Some text")
              ],
              text: searchedItems[index]["text"],
            );
          },
        )),
      ],
    );
  }
}
