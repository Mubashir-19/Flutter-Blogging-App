import 'package:flutter/material.dart';
import 'package:se_project/widgets/account.dart';
import 'package:se_project/widgets/createBlog.dart';
import 'package:se_project/widgets/searchpage.dart';
import 'widgets/HomeFeed.dart';
// import 'widgets/tags.dart';

class Home extends StatefulWidget {
  final double statusBarHeight;
  final String email;
  final String username;

  int selectedBottomButton = 0;
  final PageController _pageController = PageController(initialPage: 0);
  // Use the named parameter syntax for the constructor
  Home(
      {Key? key,
      required this.statusBarHeight,
      required this.email,
      required this.username})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // print(statusBarHeight);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateBlog(widget.email),
              ),
            );
          },
          tooltip: 'Add Blog',
          shape: const CircleBorder(),
          mini: true,
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.edit_square,
            size: 20,
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: widget.statusBarHeight),
          color: Colors.black87,
          // height: MediaQuery.of(context).size.height * 0.20,
          child: PageView(
            // scrollBehavior: CupertinoScrollBehavior(),
            controller: widget._pageController,
            onPageChanged: (value) {
              return setState(() {
                widget.selectedBottomButton = value;
              });
            },
            children: [
              const HomeFeed(),
              const SearchPage(),
              Account(email: widget.email, username: widget.username)
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black87,
          height: MediaQuery.of(context).size.height * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => {
                  widget._pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease)
                },
                icon: widget.selectedBottomButton == 0
                    ? const Icon(
                        Icons.home,
                        size: 30,
                        color: Colors.white70,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        color: Colors.white70,
                      ),
              ),
              IconButton(
                  onPressed: () => {
                        widget._pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease)
                      },
                  icon: widget.selectedBottomButton == 1
                      ? const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 233, 233, 233),
                          weight: 100,
                          size: 30,
                        )
                      : const Icon(
                          Icons.search,
                          color: Colors.white70,
                        )),
              IconButton(
                onPressed: () => {
                  widget._pageController.animateToPage(2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease)
                },
                icon: widget.selectedBottomButton == 2
                    ? const Icon(
                        Icons.account_circle,
                        size: 30,
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

        // BottomNavigationBar (
        //   // iconSize: 5,
        //   // fixedColor: Colors.black,
        //   key: widget.bottomNavigationBarKey,
        //   backgroundColor: const Color.fromARGB(221, 113, 66, 66),
        //   currentIndex: _currentIndex,
        //   items: _bottomNavigationBarItems,
        //   onTap: (index) {
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        // ),
        // body: Column(children: [
        //   const HomeFeed(),

        );
  }
}
