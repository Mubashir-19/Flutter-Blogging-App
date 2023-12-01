import 'package:flutter/material.dart';
import 'package:se_project/widgets/postwidget.dart';
import 'package:se_project/widgets/tagbar.dart';
import 'auth.dart';
import 'classes/comment.dart';
import 'classes/post.dart';
import 'widgets/HomeFeed.dart';
// import 'widgets/tags.dart';

class Home extends StatefulWidget {
  final double statusBarHeight;

  int selectedBottomButton = 0;
  // Use the named parameter syntax for the constructor
  Home({Key? key, required this.statusBarHeight}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void setBottomButton(int num) {
    setState(() => widget.selectedBottomButton = num);
  }

  @override
  Widget build(BuildContext context) {
    // print(statusBarHeight);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.23),
        child: Container(
          padding: EdgeInsets.only(top: widget.statusBarHeight),
          height: MediaQuery.of(context).size.height * 0.23,
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
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
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.05),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: MyTabBar(),
              )
            ],
          ),
        ),
      ),
      body: Column(children: [
        const HomeFeed(),
        Container(
          color: Colors.black87,
          height: MediaQuery.of(context).size.height * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => {setBottomButton(0)},
                icon: widget.selectedBottomButton == 0
                    ? const Icon(
                        Icons.home,
                        color: Colors.white70,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        color: Colors.white70,
                      ),
              ),
              IconButton(
                  onPressed: () => {setBottomButton(1)},
                  icon: widget.selectedBottomButton == 1
                      ? const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 233, 233, 233),
                          weight: 100,
                          size: 25,
                        )
                      : const Icon(
                          Icons.search,
                          color: Colors.white70,
                          size: 23,
                        )),
              // IconButton(
              //   onPressed: () => {setBottomButton(2)},
              //   icon: widget.selectedBottomButton == 2
              //       ? const Icon(
              //           Icons.library_books,
              //           color: Colors.white70,
              //         )
              //       : const Icon(
              //           Icons.library_books_outlined,
              //           color: Colors.white70,
              //         ),
              // ),
              IconButton(
                onPressed: () => {setBottomButton(3)},
                icon: widget.selectedBottomButton == 3
                    ? const Icon(
                        Icons.account_circle,
                        color: Colors.white70,
                      )
                    : const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white70,
                      ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
