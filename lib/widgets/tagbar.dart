import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  MyTabBar({super.key});
  int selectedTag = 0;
  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  void setTag(int num) {
    setState(() => widget.selectedTag = num);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          GestureDetector(
            onTap: () => setTag(0),
            child: Container(
                alignment: Alignment.center,
                // padding:const  EdgeInsets.only(bottom: 20),
                decoration: widget.selectedTag == 0
                    ? const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)))
                    : null,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "For you",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: widget.selectedTag == 0
                          ? FontWeight.bold
                          : FontWeight.normal),
                )),
          ),
          GestureDetector(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: widget.selectedTag == 1
                    ? const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)))
                    : null,
                child: Text(
                  "Statistics",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: widget.selectedTag == 1
                          ? FontWeight.bold
                          : FontWeight.normal),
                )),
            onTap: () => setTag(1),
          ),
          GestureDetector(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: widget.selectedTag == 2
                    ? const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)))
                    : null,
                child: Text(
                  "Data Science",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: widget.selectedTag == 2
                          ? FontWeight.bold
                          : FontWeight.normal),
                )),
            onTap: () => setTag(2),
          ),
          GestureDetector(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: widget.selectedTag == 3
                    ? const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)))
                    : null,
                child: Text(
                  "Programming",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: widget.selectedTag == 3
                          ? FontWeight.bold
                          : FontWeight.normal),
                )),
            onTap: () => setTag(3),
          ),
          GestureDetector(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: widget.selectedTag == 4
                    ? const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)))
                    : null,
                child: Text(
                  "Computer Science",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: widget.selectedTag == 4
                          ? FontWeight.bold
                          : FontWeight.normal),
                )),
            onTap: () => setTag(4),
          ),
        ]);
  }
}
