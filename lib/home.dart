import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/main.dart';

import 'package:se_project/widgets/account.dart';
import 'package:se_project/widgets/createBlog.dart';
import 'package:se_project/widgets/searchpage.dart';
import 'widgets/HomeFeed.dart';

// import 'widgets/tags.dart';

class Home extends StatefulWidget {
  final double statusBarHeight;
  final String email;
  final String username;
  final String authorid;
  final PageController _pageController = PageController(initialPage: 0);
  // Use the named parameter syntax for the constructor

  Home(
      {Key? key,
      required this.statusBarHeight,
      required this.email,
      required this.username,
      required this.authorid})
      : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int selectedBottomButton = 0;
  late Future<void> asyncInitialization;
  late var items = [];

  @override
  void initState() {
    super.initState();

    asyncInitialization = initialize();
  }

  Future<void> initialize() async {
    await Provider.of<ItemsModel>(context, listen: false)
        .getItems(widget.authorid);
    // Future.delayed(const Duration(seconds: 5), () {
    items = (context.mounted)
        ? Provider.of<ItemsModel>(context, listen: false).items
        : [];
    // print("Items: $items ${context.mounted} ");

    List<String> myLikes = [];

    for (var item in items) {
      if (item["likes"].contains(widget.authorid)) {
        myLikes.add(item["id"]);
      }
    }
    // print("My Likes: $myLikes ${context.mounted} ");
    if (context.mounted) {
      Provider.of<LikesModel>(context, listen: false).addAllLikes(myLikes);
    }
    // print(Provider.of<LikesModel>(context).myLikes);
    // });
  }

  // void pushItem(dynamic a) async {
  //   setState(() {
  //     items.add(a);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print(statusBarHeight);
    // print(widget.items);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // final response = await http.post(
            //   Uri.parse('http://192.168.100.9:4000/signup'),
            //   headers: {'Content-Type': 'application/json'},
            //   body: jsonEncode({
            //     "a": "123"
            //     // Your request body here
            //   }),
            // );

            // if (response.statusCode == 200) {
            //   print('Response: ${response.body}');
            // } else {
            //   print('Request failed with status: ${response.statusCode}');
            // }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateBlog(
                  author: widget.username,
                  authorid: widget.authorid,
                ),
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
        body: FutureBuilder<void>(
          future: asyncInitialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the async initialization to complete, show a loading indicator
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(221, 86, 86, 86),
                  color: Colors.white70,
                ),
              );
            } else {
              // if (snapshot.hasError) {
              //   QuickAlert.show(context: context, type: QuickAlertType.error);
              // }
              // If the async initialization is complete, build the actual widget tree
              return Container(
                padding: EdgeInsets.only(top: widget.statusBarHeight),
                color: Colors.black87,
                // height: MediaQuery.of(context).size.height * 0.20,
                child: PageView(
                  // scrollBehavior: CupertinoScrollBehavior(),
                  controller: widget._pageController,
                  onPageChanged: (value) {
                    return setState(() {
                      selectedBottomButton = value;
                    });
                  },
                  children: [
                    HomeFeed(),
                    SearchPage(),
                    Account(
                      email: widget.email,
                      username: widget.username,
                      authorid: widget.authorid,
                    )
                  ],
                ),
              );
            }
          },
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
                icon: selectedBottomButton == 0
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
                  icon: selectedBottomButton == 1
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
                icon: selectedBottomButton == 2
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
