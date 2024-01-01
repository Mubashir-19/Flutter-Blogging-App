// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'Login.dart';
import "register.dart";

class Auth extends StatelessWidget {
  Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: const Color.fromARGB(255, 33, 33, 33),
        appBar: AppBar(
          // backgroundColor: const Color.fromARGB(255, 33, 33, 33),
          titleTextStyle:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Login", icon: Icon(Icons.login)),
              Tab(text: "Register", icon: Icon(Icons.app_registration_rounded)),
            ],
          ),
          title: const Text(''),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Login(),
            ),
            Padding(padding: const EdgeInsets.all(20.0), child: Register()),
          ],
        ),
      ),
    );
  }
}
