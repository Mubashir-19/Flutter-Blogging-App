import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:se_project/main.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});
  final GlobalKey<FormState> _signinkey = GlobalKey<FormState>();
  TextEditingController semail = TextEditingController(text: '');
  TextEditingController spassword = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _signinkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: semail,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Enter your email or username',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: spassword,
              style: const TextStyle(color: Colors.black),
              obscureText: true,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Enter your Password',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_signinkey.currentState!.validate()) {
                    // print(semail.text + spassword.text);

                    var response = await http.post(
                        Uri.parse("${dotenv.env['host']}/signin"),
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode({
                          "email": semail.text,
                          "password": spassword.text,
                        }));

                    if (response.statusCode == 200) {
                      var data = json.decode(response.body);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('avatar', data["avatar"] ?? '');
                      prefs.setString('email', data["email"]);
                      prefs.setString('username', data["username"]);
                      prefs.setString('authorid', data["id"]);
                      if (!context.mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen(
                                  statusBarHeight: 10,
                                )),
                      );
                    } else {
                      print(response.body);
                    }

                    // sendPostRequest();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ));
  }
}
