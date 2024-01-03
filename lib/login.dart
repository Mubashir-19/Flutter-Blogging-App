import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('Logging in...'),
                              ],
                            ),
                          );
                        });
                    var response = await http.post(
                        Uri.parse("${dotenv.env['host']}/signin"),
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode({
                          "email": semail.text,
                          "password": spassword.text,
                        }));

                    if (context.mounted) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }

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
                            builder: (context) => const SplashScreen()),
                      );
                    } else if (response.statusCode == 401) {
                      if (context.mounted) {
                        QuickAlert.show(
                            title: "Incorrect Password",
                            context: context,
                            type: QuickAlertType.error);
                      }
                      // print(response.body);
                    } else if (response.statusCode == 404) {
                      if (context.mounted) {
                        QuickAlert.show(
                            title: "User Not Found",
                            context: context,
                            type: QuickAlertType.error);
                      }
                      // print(response.body);
                    } else if (response.statusCode == 500) {
                      if (context.mounted) {
                        QuickAlert.show(
                            title: "Service down, please try later",
                            context: context,
                            type: QuickAlertType.info);
                      }
                      // print(response.body);
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
