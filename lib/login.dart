import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:se_project/main.dart';
import 'package:se_project/register.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                key: _signinkey,
                child: Column(
                  children: <Widget>[
                    const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: TextFormField(
                        controller: semail,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email or username',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextFormField(
                      controller: spassword,
                      obscureText: true,
                      decoration: const InputDecoration(
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 40.0,
                      ),
                      child: GestureDetector(
                        onTap: () async {
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
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepPurple),
                          child: Center(
                              child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          )),
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Acoount?  ",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
