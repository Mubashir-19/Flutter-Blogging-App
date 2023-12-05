// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:se_project/register.dart';
import 'package:se_project/widgets/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'auth.dart';
import 'auth.dart';
import 'home.dart';

void main() {
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
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
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => email != '' && username != ''
              ? Home(
                  statusBarHeight: widget.statusBarHeight,
                  email: email,
                  username: username)
              : const Auth()));
    });
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    email = prefs.getString('email') ?? '';
    username = prefs.getString('username') ?? '';
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
