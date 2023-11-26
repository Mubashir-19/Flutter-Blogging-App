import 'package:flutter/material.dart';
import 'Login.dart';
import 'Register.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Login"),
              Tab(text: "Register"),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Login(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Register(),
            ),
          ],
        ),
      ),
    );
  }
}
