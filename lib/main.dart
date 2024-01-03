// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// import 'auth.dart';
import 'auth.dart';
import 'home.dart';

class LikesModel extends ChangeNotifier {
  final List<String> _myLikes = [];

  List<String> get myLikes => _myLikes;

  int get length => _myLikes.length;

  void clear() {
    _myLikes.clear();
    // notifyListeners();
  }

  void addLike(String postId) {
    _myLikes.add(postId);
    notifyListeners();
  }

  void addAllLikes(List<String> postIds) {
    // print(postIds);
    _myLikes.addAll(postIds);
    notifyListeners();
  }

  void remLike(String postId) {
    _myLikes.remove(postId);
    notifyListeners();
  }
}

class ItemsModel extends ChangeNotifier {
  final List<dynamic> _items = [];

  List<dynamic> get items => _items;

  void clear() {
    _items.clear();
    // notifyListeners();
  }

  void addItem(var item) {
    _items.add(item);
    notifyListeners();
  }

  // List<String> likes(postid) =>
  //     _items.firstWhere((element) => element["id"] == postid)["likes"];

  void addLike(String postid, String authorid) {
    _items
        .firstWhere((element) => element["id"] == postid)["likes"]
        .add(authorid);
    notifyListeners();
  }

  void removeLike(String postid, String authorid) {
    _items
        .firstWhere((element) => element["id"] == postid)["likes"]
        .remove(authorid);
    notifyListeners();
  }

  Future<void> getItems(String authorid) async {
    var response = await http.get(Uri.parse("${dotenv.env['host']}/getall"));

    if (response.statusCode == 200) {
      _items.addAll(json.decode(response.body));
    }
    notifyListeners();
  }
}

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsModel()),
        ChangeNotifierProvider(create: (_) => LikesModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyMaterialStateColor extends MaterialStateColor {
  static const int _defaultColor =
      0xffffffff; // Default color when no state is active

  MyMaterialStateColor() : super(_defaultColor);

  @override
  Color resolve(Set<MaterialState> states) {
    return Color.fromARGB(
        255, 30, 29, 29); // Default color when no state is active
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      // The app is about to be closed, make a call to the database here
      // For example, you can use a database package like sqflite, firebase, etc.
      // Make sure to handle the database call asynchronously.
      makeDatabaseCall();
    }
  }

  Future<void> makeDatabaseCall() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> myLikes = context.mounted
        ? Provider.of<LikesModel>(context, listen: false).myLikes
        : [];
    // final List<String> myDislikes = prefs.getStringList("dislikes") ?? [];
    final authorid = prefs.getString('authorid');
    if (authorid == null || (myLikes == [])) return;

    // print(latestLikes);
    var response = await http.get(Uri.parse("${dotenv.env['host']}/getall"));
    var items;

    if (response.statusCode == 200) {
      items = jsonDecode(response.body);
    } else {
      items = [];
    }

    for (var item in items) {
      if (item["likes"].contains(authorid) && !myLikes.contains(item["id"])) {
        http.post(
          Uri.parse('${dotenv.env['host']}/updateLikes'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "postid": item["id"],
            "authorid": authorid,
            "operation": "remove"
            // Your request body here
          }),
        );
      } else if (!item["likes"].contains(authorid) &&
          myLikes.contains(item["id"])) {
        http.post(
          Uri.parse('${dotenv.env['host']}/updateLikes'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "postid": item["id"],
            "authorid": authorid,
            "operation": "add"
            // Your request body here
          }),
        );
      }
    }
    // print(latestLikes);
    // print(items);
    // for (var postid in myLikes) {
    //   for (var item in items) {
    //     // print(item["id"] + " " + postid);
    //     // print(item["likes"].toString() + " - " + authorid);

    //     if (item["id"] == postid) {
    //       if (!item["likes"].contains(authorid)) {
    //         http.post(
    //           Uri.parse('${dotenv.env['host']}/updateLikes'),
    //           headers: {'Content-Type': 'application/json'},
    //           body: jsonEncode({
    //             "postid": postid,
    //             "authorid": authorid,
    //             "operation": "add"
    //             // Your request body here
    //           }),
    //         );
    //       }
    //     }
    //     print("${item["likes"]} ${latestLikes} ${postid}");
    //     if (item["likes"].contains(authorid) && !latestLikes.contains(postid)) {
    //       http.post(
    //         Uri.parse('${dotenv.env['host']}/updateLikes'),
    //         headers: {'Content-Type': 'application/json'},
    //         body: jsonEncode({
    //           "postid": postid,
    //           "authorid": authorid,
    //           "operation": "remove"
    //           // Your request body here
    //         }),
    //       );
    //     }
    //   }
    // }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SE Project',
        theme: ThemeData(
          tabBarTheme: TabBarTheme(
            labelColor: MyMaterialStateColor(),
            unselectedLabelColor: MyMaterialStateColor(),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          fontFamily: "Raleway",
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color.fromARGB(82, 169, 169, 169)),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
                color: Color.fromARGB(
                    255, 19, 33, 57)), // Set the default text color
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 70, 99, 172)),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class NavigationKeys {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

class _SplashScreenState extends State<SplashScreen> {
  late String email = '';
  late String username = '';
  late String authorid = '';
  late String avatar = '';
  @override
  void initState() {
    super.initState();

    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    email = prefs.getString('email') ?? '';
    username = prefs.getString('username') ?? '';
    authorid = prefs.getString('authorid') ?? '';
    avatar = prefs.getString('avatar') ?? '';

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => email != '' && username != '' && authorid != ''
              ? Home(
                  statusBarHeight: MediaQuery.of(context).padding.top,
                  email: email,
                  username: username,
                  authorid: authorid,
                  avatar: avatar)
              : Auth()));
    });
    // print(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 217, 237),
      body: Center(
          child: Image.asset(
        'images/logo.png',
        height: 100,
      )),
    );
  }
}
