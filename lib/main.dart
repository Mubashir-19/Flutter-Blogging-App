// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'auth.dart';
import 'auth.dart';
import 'home.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SE Project',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: "Raleway",
          textTheme: const TextTheme(
              // bodyMedium:
              //     TextStyle(color: Colors.white), // Set the default text color
              ),
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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "MyWords",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          CircularProgressIndicator(),
        ],
      )),
    );
  }
}
