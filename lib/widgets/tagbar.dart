import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  Function selectedTab;
  MyTabBar({super.key, required this.selectedTab});
  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int selectedTag = 0;
  final tags = [
    "for you",
    "data science",
    "machine learning",
    "computer science",
    "statistics",
    "data analysis",
    "programming"
  ];

  void setTag(int num) {
    setState(() => selectedTag = num);
    widget.selectedTab(tags[num]);
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }

    return text.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return word;
      }
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setTag(index),
            child: Container(
                alignment: Alignment.center,
                // padding:const  EdgeInsets.only(bottom: 20),
                decoration: selectedTag == index
                    ? const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)))
                    : null,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  capitalizeFirstLetter(tags[index]),
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: selectedTag == index
                          ? FontWeight.bold
                          : FontWeight.normal),
                )),
          );
        });
  }
}
