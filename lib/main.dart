// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// import 'auth.dart';
import 'auth.dart';
import 'home.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyMaterialStateColor extends MaterialStateColor {
  static const int _defaultColor =
      0xffffffff; // Default color when no state is active

  MyMaterialStateColor() : super(_defaultColor);

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Color.fromARGB(255, 207, 207, 207); // Color when pressed
    }
    if (states.contains(MaterialState.hovered)) {
      return Color.fromARGB(255, 207, 207, 207); // Color when hovered
    }
    if (states.contains(MaterialState.focused)) {
      return Color.fromARGB(255, 207, 207, 207); // Color when focused
    }
    if (states.contains(MaterialState.disabled)) {
      return Color.fromARGB(255, 207, 207, 207); // Color when disabled
    }
    return const Color(_defaultColor); // Default color when no state is active
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      // The app is about to be closed, make a call to the database here
      // For example, you can use a database package like sqflite, firebase, etc.
      // Make sure to handle the database call asynchronously.
      _makeDatabaseCall();
    }
  }

  Future<void> _makeDatabaseCall() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> latestLikes = prefs.getStringList("likes") ?? [];
    // print(latestLikes);
    var response = await http.get(Uri.parse("${dotenv.env['host']}/getall"));
    var items;
    final authorid = prefs.getString('authorid');
    if (authorid == null) return;

    if (response.statusCode == 200) {
      items = jsonDecode(response.body);
    } else {
      items = [];
    }
    // print(latestLikes);
    // print(items);
    for (var postid in latestLikes) {
      for (var item in items) {
        // print(item["id"] + " " + postid);
        // print(item["likes"].toString() + " - " + authorid);

        if (item["id"] == postid) {
          if (!item["likes"].contains(authorid)) {
            http.post(
              Uri.parse('${dotenv.env['host']}/updateLikes'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "postid": postid,
                "authorid": authorid,
                "operation": "add"
                // Your request body here
              }),
            );
          }
        }
        print("${item["likes"]} ${latestLikes} ${postid}");
        if (item["likes"].contains(authorid) && !latestLikes.contains(postid)) {
          http.post(
            Uri.parse('${dotenv.env['host']}/updateLikes'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "postid": postid,
              "authorid": authorid,
              "operation": "remove"
              // Your request body here
            }),
          );
        }
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
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
            bodyMedium:
                TextStyle(color: Colors.white), // Set the default text color
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(statusBarHeight: statusBarHeight));
  }
}

class SplashScreen extends StatefulWidget {
  final double statusBarHeight;
  const SplashScreen({super.key, required this.statusBarHeight});
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

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => email != '' && username != '' && authorid != ''
              ? Home(
                  statusBarHeight: widget.statusBarHeight,
                  email: email,
                  username: username,
                  authorid: authorid)
              : Auth()));
    });
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    email = prefs.getString('email') ?? '';
    username = prefs.getString('username') ?? '';
    authorid = prefs.getString('authorid') ?? '';
    // print(items);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white12,
      body: Center(
          child: CircularProgressIndicator(
        backgroundColor: Color.fromARGB(221, 86, 86, 86),
        color: Colors.white70,
      )),
    );
  }
}
